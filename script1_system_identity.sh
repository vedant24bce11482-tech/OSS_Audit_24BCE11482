#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Vedant ashtikar | Registration: 24BCE11482
# Course: Open Source Software | VIT Bhopal
# Purpose: Display a formatted summary of the Linux system
# ============================================================

# --- Student and project variables ---
STUDENT_NAME="Vedant ashtikar"          # Replace with your name
SOFTWARE_CHOICE="Python"             # Our chosen open-source software

# --- Collect system information using command substitution ---
KERNEL=$(uname -r)                   # Get the running kernel version
USER_NAME=$(whoami)                  # Get the currently logged-in user
UPTIME=$(uptime -p)                  # Get human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y') # Get formatted date
CURRENT_TIME=$(date '+%H:%M:%S')     # Get current time

# Detect distro name from /etc/os-release (standard across most distros)
if [ -f /etc/os-release ]; then
    DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d'=' -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# The OS kernel (Linux) is licensed under GPLv2
OS_LICENSE="GNU General Public License, Version 2 (GPL v2)"

# --- Display the report ---
echo "========================================================="
echo "   Open Source Audit — System Identity Report"
echo "   Student : $STUDENT_NAME"
echo "   Software: $SOFTWARE_CHOICE"
echo "========================================================="
echo ""
echo "  Distribution : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME"
echo "  System Uptime : $UPTIME"
echo "  Date and Time : $CURRENT_DATE at $CURRENT_TIME"
echo ""
echo "---------------------------------------------------------"
echo "  OS Licence    : $OS_LICENSE"
echo "  This means the OS source code is freely available,"
echo "  modifiable, and redistributable under the same terms."
echo "=========================================================="
echo ""
