class Switchboard < Formula
  desc "Launch the right coding CLI on the right account"
  homepage "https://github.com/paulmeller/switchboard"
  url "https://github.com/paulmeller/switchboard/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "3230f65a7f58c723c10948ab9b0d5ee10d2d319c960a1aec2d104184a7bebbbb"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"sb"), "./cmd/sb"
  end

  test do
    assert_match "0.1.2", shell_output("#{bin}/sb --version")
  end
end
