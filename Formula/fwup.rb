class Fwup < Formula
  desc "Configurable embedded Linux firmware update creator and runner"
  homepage "https://github.com/fhunleth/fwup"
  url "https://github.com/fhunleth/fwup/releases/download/v1.2.7/fwup-1.2.7.tar.gz"
  sha256 "6fbc4c751ed5cc78109763d7f60d54c6782534276f12e02a726d08844e7200f9"

  bottle do
    cellar :any
    sha256 "e7c1f820c368c1e083f585e2ba61e9864d67b3f120873d2c95aae7f7f36dc1c1" => :mojave
    sha256 "1c3ce53c5cac1e2c2082f16d756630411bb787aea39438b17d13ac89c111f794" => :high_sierra
    sha256 "5ea71af2a6e0642743937ea9eca085c0e5aa87ba50394fd330cce5ee85437e99" => :sierra
  end

  depends_on "pkg-config" => :build
  depends_on "confuse"
  depends_on "libarchive"
  depends_on "libsodium"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system bin/"fwup", "-g"
    assert_predicate testpath/"fwup-key.priv", :exist?, "Failed to create fwup-key.priv!"
    assert_predicate testpath/"fwup-key.pub", :exist?, "Failed to create fwup-key.pub!"
  end
end
