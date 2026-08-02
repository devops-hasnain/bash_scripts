#!/bin/bash

# ================================================++==============================
# DEVOPS LOG ANALYSIS AUTOMATION SCRIPT
# Location: /ubuntu/home/analyze_logs.sh
# Purpose: Dynamic daily health monitoring of system and application logs.
# =========================================================================

# --- Variables Configuration ---
# Absolute directory path where log files are stored
log_directory="/ubuntu/home/data_files"

# Array containing the error severity patterns to look for
error_patterns=("error" "fatal" "critical")

# ==========================================================================
# MAIN LOGIC
# ============================================================+=================

echo "=================================================="
echo "   DEVOPS LOG ANALYSIS REPORT - $(date)"
echo "=================================================="

# STEP 1: Command Substitution
# Find all files ending in '.log' inside the directory modified in the last 24 hours (-mtime -1)
echo -e "\n[INFO] Scanning for log files updated in the last 24 hours..."
log_files=$(find "$log_directory" -name "*.log" -mtime -1)

# Check if any modified log files were found; if none, exit gracefully
if [ -z "$log_files" ]; then
    echo "No log files have been modified within the last 24 hours. Exiting."
    exit 0
fi

echo -e "Files found to process:\n$log_files"

# STEP 2: Outer Loop - Iterate through each discovered log file
for log_file in $log_files; do
    echo -e "\n=================================================="
    echo " ANALYZING FILE: $log_file"
    echo "=================================================="

    # STEP 3: Inner Loop - Iterate through each error severity pattern dynamically
    for pattern in "${error_patterns[@]}"; do
        echo -e "\n--------------------------------------------------"
        echo " Searching [${pattern^^}] logs in: $(basename "$log_file")"
        echo "--------------------------------------------------"
        
        # Display the actual matching log lines (-i for case-insensitive matching)
        grep -i "$pattern" "$log_file"
        
        # Count the number of matches and capture it in a variable
        match_count=$(grep -i -c "$pattern" "$log_file")
        
        # Print human-readable summary metrics with clean visual spacing
        echo -e "\n>>> Number of [${pattern^^}] logs found: $match_count"
    done
done

echo -e "\n=================================================="
echo "   ANALYSIS COMPLETE"
echo "=================================================="
