#!/bin/bash

#$Revision:001$
#$Thu July 30 7:30 PM PST$

# Printing the current date and time first
echo "========================================"
echo "Script started at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================"

# Define paths
SOURCE_DIR="/var/log"
ARCHIVE_DIR="/home/archive"

# Check if the archive folder exists; if not, create it
if [ ! -d "$ARCHIVE_DIR" ]; then
        echo "Archive directory does not exist. Creating '$ARCHIVE_DIR'..."
        mkdir -p "$ARCHIVE_DIR"
fi

echo "Scanning '$SOURCE_DIR' and compressing files..."
echo "Please wait..."

# Initialize a variable to hold the list of processed files
COMPRESSED_FILES=""

# Find files in /var/log larger than 10KB
# Exclude already compressed files (.gz)
while read -r file; do
        filename=$(basename "$file")
        archive_name="${filename}-$(date +%F).gz"
 # Compress the file
    gzip -c "$file" > "$ARCHIVE_DIR/$archive_name"

    # Append the filename to our summary list group
    COMPRESSED_FILES+="- $archive_name\n"

done < <(find "$SOURCE_DIR" -type f -size +10k ! -name "*.gz" 2>/dev/null)

# Print the grouped output at the end
echo "========================================"
echo "The following files have been compressed:"
echo -e "$COMPRESSED_FILES"
echo "Location of archived files:"
echo "-> $ARCHIVE_DIR/"
echo "----------------------------------------"
echo "Success: Implementation completed successfully."
echo "========================================"
