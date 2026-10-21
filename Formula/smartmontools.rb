class Smartmontools < Formula
  desc "SMART hard drive monitoring"
  homepage "https://www.smartmontools.org/"
  # 7.x needs C++11; Xcode 3.1 on Leopard only has gcc 4.0/4.2.
  # 6.6 is the last release that still builds as C++98.
  url "https://downloads.sourceforge.net/project/smartmontools/smartmontools/6.6/smartmontools-6.6.tar.gz"
  sha256 "51f43d0fb064fccaf823bbe68cf0d317d0895ff895aa353b3339a3b316a53054"

  def install
    (var/"run").mkpath
    (var/"lib/smartmontools").mkpath

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sbindir=#{bin}",
                          "--sysconfdir=#{etc}",
                          "--localstatedir=#{var}",
                          "--with-savestates",
                          "--with-attributelog",
                          "--without-cxx11-option",
                          "--without-nvme-devicescan"
    system "make", "install"
  end

  test do
    assert_match "smartctl 6.6", shell_output("#{bin}/smartctl --version")
  end
end
