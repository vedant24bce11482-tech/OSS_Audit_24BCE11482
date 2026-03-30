#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Vedant ashtikar | Course: Open Source Software
# Purpose: Report permissions and sizes of key Linux directories
# ============================================================

# List of important system directories to audit
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/opt")

echo "========================================================"
echo "  Directory Audit Report"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================================"
printf "%-25s %-22s %-8s\n" "Directory" "Permissions/Owner" "Size"
echo "--------------------------------------------------------"

# --- Loop through each directory and report its details ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls -ld and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3 ":" $4}')
        # Get human-readable disk usage; suppress error for restricted dirs
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "%-25s %-22s %-8s\n" "$DIR" "$PERMS $OWNER" "${SIZE:-N/A}"
    else
        printf "%-25s %-22s\n" "$DIR" "[Does not exist]"
    fi
done

echo ""
echo "--- Python Installation Check ---"

# Check for Python's site-packages directory (varies by version)
PYTHON_DIRS=("/usr/lib/python3" "/usr/local/lib/python3" "/usr/lib/python3/dist-packages")

for PYDIR in "${PYTHON_DIRS[@]}"; do
    if [ -d "$PYDIR" ]; then
        PYPERMS=$(ls -ld "$PYDIR" | awk '{print $1, $3, $4}')
        echo "Found: $PYDIR"
        echo "       Permissions: $PYPERMS"
    fi
done

# Also check the Python binary location
PYTHON_BIN=$(which python3 2>/dev/null)
if [ -n "$PYTHON_BIN" ]; then
    echo "Python binary : $PYTHON_BIN"
    echo "Binary perms  : $(ls -l $PYTHON_BIN | awk '{print $1, $3, $4}')"
    echo "Python version: $(python3 --version 2>&1)"
else
    echo "python3 binary not found in PATH."
fi

echo "========================================================"
