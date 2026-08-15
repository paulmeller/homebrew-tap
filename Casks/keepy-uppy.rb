cask "keepy-uppy" do
  version "0.1.6"
  sha256 "05d3f20185772b4345f79e5e88221eef59d151da65a6932b5d28d760da39d032"

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

  # Registers the background services after every install and upgrade.
  #
  # **Why unconditionally, rather than only on upgrade.** An upgrade is an
  # uninstall followed by an install, so the `uninstall` stanza below has
  # already run `reset` and unregistered both services by the time this runs —
  # which means "only re-register if the daemon is still answering" would never
  # fire on the one path it was written for. Asking `keepy-uppy status` here
  # tells you nothing useful for the same reason.
  #
  # Running it on a fresh install is not a cost worth avoiding: `setup` is
  # exactly what the app's own Enable button does, it does not block on a
  # password, and a user who just installed a keep-awake utility is not
  # surprised to be asked to approve its background items.
  #
  # `must_succeed: false` deliberately. A failure here — most likely macOS
  # declining until the user approves in Login Items — must not fail the whole
  # install and leave a cask Homebrew thinks is broken. The app reports its own
  # service state in Settings, which is where an unapproved service is visible
  # and fixable.
  #
  # It runs as the user, which is required rather than incidental: `setup`
  # registers a *per-user* agent alongside the daemon, and one registered by
  # root belongs to root.
  postflight do
    system_command "#{appdir}/Keepy Uppy.app/Contents/MacOS/keepy-uppy",
                   args: ["setup"],
                   must_succeed: false
  end

  # Left behind by `reset` on purpose — your triggers, guards and wake-mode
  # choices outlive a reinstall unless you ask for them to go.
  zap trash: [
    "~/Library/Preferences/au.com.workwireless.keepy-uppy.plist",
  ]

  caveats <<~EOS
    The background services are registered for you. macOS may ask you to
    approve them once, in System Settings > General > Login Items & Extensions
    — Settings > General in Keepy Uppy shows whether they are running.

    On a headless Mac that will never run the app:

      "#{appdir}/Keepy Uppy.app/Contents/MacOS/keepy-uppy" setup
  EOS
end
