#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Vedant ashtikar | Course: Open Source Software
# Purpose: Count keyword occurrences in a log file and
#          display the last 5 matching lines.
# Usage  : ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Handle command-line arguments ---
LOGFILE=$1                     # First argument: path to log file
KEYWORD=${2:-"error"}           # Second argument: keyword (default: 'error')
COUNT=0                        # Counter variable, initialised to zero

# --- Validate that a log file was provided ---
if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile> [keyword]"
    exit 1
fi

# Retry up to 3 times if the file is missing (handles transient NFS issues)
RETRY=0
while [ ! -f "$LOGFILE" ] && [ $RETRY -lt 3 ]; do
    echo "File not found: $LOGFILE. Retrying in 2 seconds... (attempt $((RETRY+1)))"
    sleep 2
    RETRY=$((RETRY + 1))
done

# Final check after retry loop
if [ ! -f "$LOGFILE" ]; then
    echo "ERROR: File $LOGFILE not found after $RETRY attempts."
    exit 1
fi

# Check if file is empty
if [ ! -s "$LOGFILE" ]; then
    echo "WARNING: File $LOGFILE is empty. Nothing to analyse."
    exit 0
fi

echo "Analysing: $LOGFILE"
echo "Keyword  : $KEYWORD"
echo "-----------------------------------"

# --- Read file line by line and count keyword matches ---
# IFS= preserves leading whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do
    # Case-insensitive grep to match keyword in this line
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment counter for each match
    fi
done < "$LOGFILE"

echo "Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE."
echo ""

# --- Print the last 5 matching lines for context ---
if [ $COUNT -gt 0 ]; then
    echo "Last 5 matching lines:"
    echo "-----------------------------------"
    grep -i "$KEYWORD" "$LOGFILE" | tail -5
else
    echo "No matches found. The log appears clean for keyword '$KEYWORD'."
fi

echo "-----------------------------------"
echo "Analysis complete."
