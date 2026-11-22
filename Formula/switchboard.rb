class Switchboard < Formula
  desc "Launch the right coding CLI on the right account"
  homepage "https://github.com/paulmeller/switchboard"
  url "https://github.com/paulmeller/switchboard/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "8bec15d46150aa84ea4f45c50d5da9168b351cf6059ffe5871040ffeee6e932f"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"sb"), "./cmd/sb"
  end

  test do
    assert_match "0.1.3", shell_output("#{bin}/sb --version")
  end
end
