#!/bin/bash
set -e

TARGET_DIR="$1"
# $0 is the path to this script.
BOARD_DIR="$(dirname "$0")"

echo "Running post-build script for ShredOS..."

# Apply patch for archive_log.sh
if [ -f "$BOARD_DIR/patches/archive_log_pdf.patch" ]; then
    echo "Applying archive_log_pdf.patch..."
    # The patch was generated with paths relative to TARGET_DIR (e.g. usr/bin/...)
    # so we use -p0 and run from TARGET_DIR.
    patch -d "$TARGET_DIR" -p0 < "$BOARD_DIR/patches/archive_log_pdf.patch"
else
    echo "Warning: archive_log_pdf.patch not found in $BOARD_DIR/patches/"
    exit 1
fi

# Switch to hybrid_launcher in inittab
if [ -f "$TARGET_DIR/etc/inittab" ]; then
    echo "Configuring inittab to use hybrid_launcher..."
    if grep -q "nwipe_launcher" "$TARGET_DIR/etc/inittab"; then
        sed -i 's|/usr/bin/nwipe_launcher|/usr/bin/hybrid_launcher|g' "$TARGET_DIR/etc/inittab"
    else
        echo "Warning: nwipe_launcher not found in inittab. Is hybrid_launcher already set?"
    fi
else
    echo "Warning: inittab not found in target."
    exit 1
fi

echo "Post-build script completed successfully."
