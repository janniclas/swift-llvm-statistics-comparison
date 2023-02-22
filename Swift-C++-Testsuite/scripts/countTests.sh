#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 directory file_extension"
    exit 1
fi

dir=$1
ext=$2

if [ ! -d "$dir" ]; then
    echo "$dir is not a directory."
    exit 1
fi

echo "Counting files with extension .$ext in $dir and subdirectories:"

total_count=0

find "$dir" -type d -print0 | while read -d $'\0' d; do
    count=$(find "$d" -maxdepth 1 -name "*.$ext" | wc -l)
    # echo "$d: $count"
    total_count=$((total_count+count))
done

find "$dir" -mindepth 1 -maxdepth 1 -type d -print0 | while read -d $'\0' d; do
    count=$(find "$d" -type f -name "*.$ext" | wc -l)
    echo "$d: $count"
done

# echo "Total count of .$ext files in $dir and subdirectories: $total_count"
