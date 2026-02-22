class Warehouse < Formula
  desc "Fast CLI for personal data warehouse - extraction, FTS5 search, and browsing"
  homepage "https://github.com/paulmeller/warehouse-cli"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v0.3.1/warehouse-macos-arm64.tar.gz"
      sha256 "cd96a3efc2b701771f0d0785ec27a6d0d3d4b690ce2c82bab2f04b07d30cd2fd"
    else
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v0.3.1/warehouse-macos-x86_64.tar.gz"
      sha256 "cd5cb6ce34e5d6db6bf0bde246979b52f456dd863d78f8fbeff1c3463f22e2eb"
    end
  end

  def install
    bin.install "warehouse"
  end

  test do
    assert_match "Personal data warehouse", shell_output("#{bin}/warehouse --help")
  end
end
