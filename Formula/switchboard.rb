class Switchboard < Formula
  desc "Launch the right coding CLI on the right account"
  homepage "https://github.com/paulmeller/switchboard"
  url "https://github.com/paulmeller/switchboard/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "3cc44e4476fab06814f620c13d5bdab93352afcc7b19cf42334044e2b4a4adb3"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"sb"), "./cmd/sb"
  end

  test do
    assert_match "0.1.1", shell_output("#{bin}/sb --version")
  end
end
