cask "keepy-uppy" do
  version "0.1.2"
  sha256 "86cf98f4b168b8ee017525f61a558459f1338e68a06ad7a3e67e7e9409e81dd6"

  url "https://github.com/paulmeller/keepy-uppy/releases/download/v#{version}/Keepy.Uppy.dmg"
  name "Keepy Uppy"
  desc "Keeps a Mac awake with the lid closed"
  homepage "https://github.com/paulmeller/keepy-uppy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Keepy Uppy.app"

  # `reset` has to run while the bundle is still on disk, and it is the only
  # safe way to remove this app.
  #
  # The daemon owns a system-level `SleepDisabled` setting that survives both
  # process death and reboot. Evicting the daemon while a session is live would
  # leave that setting on with nothing left running that could clear it — a Mac
  # permanently unable to sleep. `reset` therefore asks the daemon to put the
  # machine back *first* and only then unregisters, and it refuses the eviction
  # outright if it cannot. That refusal exits non-zero and deliberately aborts
  # this uninstall: stopping with the app still installed is the recoverable
  # outcome, and forcing `launchctl bootout` past it is the one that strands the
  # machine.
  #
  # `early_script` is the only uninstall phase that runs before the app is
  # removed and before `launchctl` tears the services down, which is why the
  # call lives here rather than in `script`. It needs no `sudo`: `unregister()`
  # goes through SMAppService, and `smd` performs the privileged eviction on the
  # user's behalf.
  uninstall early_script: {
              executable: "#{appdir}/Keepy Uppy.app/Contents/MacOS/keepy-uppy",
              args:       ["reset"],
            },
            launchctl:    [
              "au.com.workwireless.keepy-uppy.helper",
              "au.com.workwireless.keepy-uppy.agent",
            ],
            quit:         "au.com.workwireless.keepy-uppy"

  # Left behind by `reset` on purpose — your triggers, guards and wake-mode
  # choices outlive a reinstall unless you ask for them to go.
  zap trash: [
    "~/Library/Preferences/au.com.workwireless.keepy-uppy.plist",
  ]

  caveats <<~EOS
    Keepy Uppy needs its background services approved once before it can do
    anything. Open it and hit "Enable Keepy Uppy", then approve the two Login
    Items macOS asks about.

    On a headless Mac that will never run the app:

      "#{appdir}/Keepy Uppy.app/Contents/MacOS/keepy-uppy" setup
  EOS
end
