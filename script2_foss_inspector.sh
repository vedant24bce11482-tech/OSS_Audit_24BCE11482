#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Vedant ashtikar | Course: Open Source Software
# Purpose: Check if a FOSS package is installed and print
#          version info and a philosophy note about it.
# Usage  : ./script2_foss_inspector.sh [package_name]
# Example: ./script2_foss_inspector.sh python3
# ============================================================

# Use the first argument if provided, otherwise default to python3
PACKAGE=${1:-python3}

echo "============================================"
echo "  FOSS Package Inspector"
echo "  Checking package: $PACKAGE"
echo "============================================"

# --- Check if the package is installed ---
# Try dpkg first (Debian/Ubuntu), then rpm (RHEL/Fedora)
if dpkg -l "$PACKAGE" &>/dev/null 2>&1; then
    echo "STATUS: $PACKAGE is installed (via dpkg)."
    # Extract and display version information
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "Version: " $3}'
    echo ""
    # Show full package details, filtering for useful fields
    dpkg -s "$PACKAGE" 2>/dev/null | grep -E 'Package|Version|Maintainer|Homepage'

elif rpm -q "$PACKAGE" &>/dev/null 2>&1; then
    echo "STATUS: $PACKAGE is installed (via rpm)."
    # Display version, licence and summary from rpm metadata
    rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary|URL'

else
    echo "STATUS: $PACKAGE is NOT installed on this system."
    echo "To install it, try:"
    echo "  Ubuntu/Debian : sudo apt install $PACKAGE"
    echo "  RHEL/Fedora   : sudo dnf install $PACKAGE"
fi

echo ""
echo "--------------------------------------------"
echo "  Philosophy Note:"

# --- Case statement: print a philosophy note per package ---
case $PACKAGE in
    python3|python)
        echo "Python: a language built in the open,"
        echo "shaped entirely by its community, and given"
        echo "freely to the world under the PSF licence."
        ;;
    httpd|apache2)
        echo "Apache: the web server that helped build"
        echo "the open internet, powering ~30% of all sites."
        ;;
    mysql|mariadb)
        echo "MySQL/MariaDB: open-source at the heart of"
        echo "millions of apps. MariaDB was born when the"
        echo "community forked MySQL after Oracle acquired it."
        ;;
    git)
        echo "Git: Linus Torvalds built this after a proprietary"
        echo "tool failed him. Now it underpins all of modern"
        echo "open-source collaboration."
        ;;
    firefox)
        echo "Firefox: a nonprofit fighting to keep the web"
        echo "open, because a browser is also a political choice."
        ;;
    vlc)
        echo "VLC: built by students in Paris who just wanted"
        echo "to stream video over their university network."
        ;;
    *)
        echo "$PACKAGE: another piece of the open-source"
        echo "foundation that the modern world runs on."
        ;;
esac

echo "============================================"
