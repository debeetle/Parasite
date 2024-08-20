_VERSION = 0.8
VERSION  = `git describe --tags --dirty 2>/dev/null || echo $(_VERSION)`

PKG_CONFIG = pkg-config

# paths
PREFIX = /usr/local
MANDIR = $(PREFIX)/share/man
DATADIR = $(PREFIX)/share

WLR_INCS = `$(PKG_CONFIG) --cflags wlroots-0.19`
WLR_LIBS = `$(PKG_CONFIG) --libs wlroots-0.19`

# XWAYLAND =
# XLIBS =
# Uncomment to build XWayland support
XWAYLAND = -DXWAYLAND
XLIBS = xcb xcb-icccm

CC = cc
