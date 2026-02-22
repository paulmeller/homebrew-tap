class Warehouse < Formula
  desc "Fast CLI for personal data warehouse - extraction, FTS5 search, and browsing"
  homepage "https://github.com/paulmeller/warehouse-cli"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v0.3.0/warehouse-macos-arm64.tar.gz"
      sha256 ""
    else
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v0.3.0/warehouse-macos-x86_64.tar.gz"
      sha256 ""
    end
  end

  def install
    bin.install "warehouse"
  end

  test do
    assert_match "Personal data warehouse", shell_output("#{bin}/warehouse --help")
  end
end
