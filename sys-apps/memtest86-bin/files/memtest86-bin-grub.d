#!/bin/sh
exec tail -n +3 $0

menuentry "memtest86-bin" {
	chainloader /memtest86-bin.efi
}
