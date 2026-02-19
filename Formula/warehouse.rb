class Warehouse < Formula
  desc "Fast CLI for personal data warehouse - extraction, FTS5 search, and browsing"
  homepage "https://github.com/paulmeller/warehouse-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v#{version}/warehouse-macos-arm64.tar.gz"
      sha256 "e0c6b1ee443e17b639b6be540ec3239f99d1c0779270c8666fd419ecda488c8a"
    else
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v#{version}/warehouse-macos-x86_64.tar.gz"
      sha256 "d79b896a81782b96af56c572cd7134dc21add37bcac1c3b9a462f6da6422d39d"
    end
  end

  def install
    bin.install "warehouse"
  end

  test do
    assert_match "Personal data warehouse", shell_output("#{bin}/warehouse --help")
  end
end
