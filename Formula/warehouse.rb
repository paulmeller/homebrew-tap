class Warehouse < Formula
  desc "Fast CLI for personal data warehouse - extraction, FTS5 search, and browsing"
  homepage "https://github.com/paulmeller/warehouse-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v#{version}/warehouse-macos-arm64.tar.gz"
      sha256 "2e9b05168e9c4fcdbf76c60b17e4df5c9a9fd52dda7b7215c88d8e81c2beb2cb"
    else
      url "https://github.com/paulmeller/warehouse-cli/releases/download/v#{version}/warehouse-macos-x86_64.tar.gz"
      sha256 "84276cd123640c782edca70a5bfe44b813b8a7ab63339004416d3672b9d2fbb5"
    end
  end

  def install
    bin.install "warehouse"
  end

  test do
    assert_match "Personal data warehouse", shell_output("#{bin}/warehouse --help")
  end
end
