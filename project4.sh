#!/bin/bash

# 1. Checking if the script is being runby the root user
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (or using sudo)."
    exit 1
fi

# 2. Checking now if at least a username argument is prvided
if [ -z "$1" ]; then
    echo "Error: No username provided."
    echo "Usage: $0 <username> [comment text...]"
    exit 1
fi

# 3. Extractoing now positional arguments
USERNAME="$1"
shift  # Remove the username from the argument list
COMMENT="$*" # Treat all remaining arguments as a single comment string

#4. Check if the user already exists
if id "$USERNAME" &>/dev/null; then
    echo "Error: The user '$USERNAME' already exists on this system."
    exit 1
fi

# 5. Generate a secure, random 12-character password
PASSWORD=$(head /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 12)

# 6. Create the user with the comment and a home directory
if [ -n "$COMMENT" ]; then
                                                         
useradd -m -c "$COMMENT" -s /bin/bash "$USERNAME"
else
    useradd -m -s /bin/bash "$USERNAME"
fi

# 7. Set the generated password for the user
echo "$USERNAME:$PASSWORD" | chpasswd

# 8. Fetch the system's hostname or IP address
HOSTNAME=$(hostname)

# 9. Display the output on screen
echo "========================================"
echo "User Creation Successful!"
echo "========================================"
echo "Username : $USERNAME"
echo "Password : $PASSWORD"
echo "Host     : $HOSTNAME"
echo "========================================"
