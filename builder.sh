#!/bin/bash
set -e

PKG_NAME="file"
PKG_VERSION="5.45"
SOURCE_URL="https://ftp.osuosl.org/pub/blfs/conglomeration/file/${PKG_NAME}-${PKG_VERSION}.tar.gz"
BUILD_DIR="$(pwd)/build"
PKG_DIR="$(pwd)/pkg"

echo "=== [1/5] Çalışma dizinleri hazırlanıyor ==="
rm -rf "$BUILD_DIR" "$PKG_DIR"
mkdir -p "$BUILD_DIR" "$PKG_DIR"

echo "=== [2/5] Kaynak kod indiriliyor ve açılıyor ==="
cd "$BUILD_DIR"
curl -L -O "$SOURCE_URL"
tar -xf "${PKG_NAME}-${PKG_VERSION}.tar.gz"
cd "${PKG_NAME}-${PKG_VERSION}"

echo "=== [3/5] Kaynak kod derleniyor (Configure & Make) ==="
./configure --prefix=/usr
make -j$(nproc)

echo "=== [4/5] İzole klasöre kurulum yapılıyor (DESTDIR) ==="
make DESTDIR="$PKG_DIR" install

echo "=== [5/5] Ahz file paketi (.tar.xz) oluşturuluyor ==="
cd "$PKG_DIR"
tar -cJf "../${PKG_NAME}-${PKG_VERSION}-x86_64.tar.xz" *

echo "İşlem Tamam! Paket hazır: $(pwd)/../${PKG_NAME}-${PKG_VERSION}-x86_64.tar.xz"
