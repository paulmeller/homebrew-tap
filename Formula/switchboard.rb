class Switchboard < Formula
  desc "Launch the right coding CLI on the right account"
  homepage "https://github.com/paulmeller/switchboard"
  url "https://github.com/paulmeller/switchboard/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "8bfd526e69fed83a0fd5b5bb7f3255cd1bb34d1e361942885c23949631ceaca1"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"sb"), "./cmd/sb"
  end

  test do
    assert_match "0.1.4", shell_output("#{bin}/sb --version")
  end
end
