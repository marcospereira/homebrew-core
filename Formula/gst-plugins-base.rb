require "formula"

class GstPluginsBase < Formula
  homepage "http://gstreamer.freedesktop.org/"
  url "http://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.4.5.tar.xz"
  mirror "http://ftp.osuosl.org/pub/blfs/svn/g/gst-plugins-base-1.4.5.tar.xz"
  sha256 "77bd8199e7a312d3d71de9b7ddf761a3b78560a2c2a80829d0815ca39cbd551d"

  bottle do
    sha1 "6a50448b0ef09c2e2af1e24bb4e5304f42559f87" => :yosemite
    sha1 "9750ea2eac3e1653eb0003404fb3c27d568d9add" => :mavericks
    sha1 "e5aeb6aac3c04bf0b0f9583ef9f89052c52cc5ba" => :mountain_lion
  end

  head do
    url "git://anongit.freedesktop.org/gstreamer/gst-plugins-base"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gstreamer"

  # The set of optional dependencies is based on the intersection of
  # gst-plugins-base-0.10.35/REQUIREMENTS and Homebrew formulae
  depends_on "gobject-introspection"
  depends_on "orc" => :optional
  depends_on "gtk+" => :optional
  depends_on "libogg" => :optional
  depends_on "pango" => :optional
  depends_on "theora" => :optional
  depends_on "libvorbis" => :optional

  def install

    # gnome-vfs turned off due to lack of formula for it.
    args = %W[
      --prefix=#{prefix}
      --enable-experimental
      --disable-libvisual
      --disable-alsa
      --disable-cdparanoia
      --without-x
      --disable-x
      --disable-xvideo
      --disable-xshm
      --disable-debug
      --disable-dependency-tracking
      --enable-introspection=yes
    ]

    if build.head?
      ENV["NOCONFIGURE"] = "yes"
      system "./autogen.sh"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
