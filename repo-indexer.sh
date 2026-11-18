#!/bin/bash
set -e

DB_FILE="packages.db"
echo "Ahz deposu taranıyor ve $DB_FILE güncelleniyor..."

# JSON dizisini başlat
echo "[" > "$DB_FILE"

first=true
for pkg in *.tar.xz; do
  if [ -f "$pkg" ]; then
    # Dosya boyutu ve SHA256 özetini al
    size=$(stat -c%s "$pkg")
    sha=$(sha256sum "$pkg" | awk '{print $1}')
    
    if [ "$first" = true ]; then
      first=false
    else
      echo "," >> "$DB_FILE"
    fi

    cat <<EOF >> "$DB_FILE"
  {
    "filename": "$pkg",
    "size": $size,
    "sha256": "$sha"
  }
EOF
  fi
done

echo "" >> "$DB_FILE"
echo "]" >> "$DB_FILE"
echo "İşlem Tamam! $DB_FILE başarıyla güncellendi."
