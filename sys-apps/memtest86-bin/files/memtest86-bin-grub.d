#!/bin/sh -e
echo "Adding memtest86-bin" >&2

cat << EOF
menuentry "memtest86-bin" {
	chainloader /memtest86-bin.efi
}
EOF
