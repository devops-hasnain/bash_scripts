#!/bin/bash


if [ -z "$1" ]; then
    echo "Error: Please provide a path to check."
    echo "Usage: $0 <path>"
    exit 1
fi

path=$1


if [ -f "$path" ]; then 
    echo "$path is a FILE"

elif [ -d "$path" ]; then
    echo "$path is a DIRECTORY"
else 
    echo "$path is neither file nor directory"
fi
