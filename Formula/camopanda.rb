class Camopanda < Formula
  desc "Test website and API responses to different browser and device request headers"
  homepage "https://github.com/paulmeller/camopanda"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/paulmeller/camopanda/releases/download/v0.2.0/camopanda-macos-arm64.tar.gz"
      sha256 "a0aab2bae7bde5e23773d32b43ab41a30d77bbce49a4a1a753ac8cca17b6741d"

      def install
        bin.install "camopanda"
        bin.install "lightpanda"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/paulmeller/camopanda/releases/download/v0.2.0/camopanda-linux-amd64.tar.gz"
      sha256 "94d75e819f59ffd704dfe7e08bb1032f1e0103fbc61ba700df1018c7efb7b8f1"

      def install
        bin.install "camopanda"
        bin.install "lightpanda"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/paulmeller/camopanda/releases/download/v0.2.0/camopanda-linux-arm64.tar.gz"
      sha256 "683a29b999c59d0a42ee44c1e4d696e48130862f612bfe2e28be168034c850cc"

      def install
        bin.install "camopanda"
        bin.install "lightpanda"
      end
    end
  end

  test do
    assert_match "1.", shell_output("#{bin}/camopanda version")
  end
end
