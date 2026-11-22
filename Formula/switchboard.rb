class Switchboard < Formula
  desc "Launch the right coding CLI on the right account"
  homepage "https://github.com/paulmeller/switchboard"
  url "https://github.com/paulmeller/switchboard/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "18709af602c1b4656cf3bec7bab53fab20a56f645fb123b329a9411a6735724b"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"sb"), "./cmd/sb"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/sb --version")
  end
end
