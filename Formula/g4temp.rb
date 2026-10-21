class G4temp < Formula
  desc "Read the MAX6642 temperature sensor of a Mac mini G4"
  homepage "https://github.com/747500/macmini-g4-thermal"
  url "https://github.com/747500/macmini-g4-thermal/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b0daa4a4ad9955ce13b73c1fa2f5238cec40186743a8a0865b5ed32e764a0dcf"
  head "https://github.com/747500/macmini-g4-thermal.git"

  def install
    system "make", "install", "PREFIX=#{prefix}", "CC=#{ENV.cc}"
  end

  def caveats; <<-EOS.undent
    g4temp needs root: sudo g4temp (or sudo g4temp -p for Prometheus text).
    It only works on a Mac mini G4 (temp-monitor node, compatible "max6642").
    EOS
  end

  test do
    # Without root the tool must refuse cleanly instead of touching the bus.
    assert_match "must run as root", shell_output("#{bin}/g4temp 2>&1", 1)
  end
end
