class Warehouse < Formula
  desc "Fast CLI for personal data warehouse - extraction, FTS5 search, and browsing"
  homepage "https://github.com/paulmeller/warehouse-cli"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v0.3.2/warehouse-macos-arm64.tar.gz"
      sha256 "58d954e387e194c233b49686993c3116c99d4a05fb02c42cc6e1e1e67bf95e50"
    else
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v0.3.2/warehouse-macos-x86_64.tar.gz"
      sha256 "eab29d6cc8eda365f2c5aec6915e240a1d8042abe39f2fb867b340e5ee69b9c1"
    end
  end

  def install
    bin.install "warehouse"
  end

  test do
    assert_match "Personal data warehouse", shell_output("#{bin}/warehouse --help")
  end
end
