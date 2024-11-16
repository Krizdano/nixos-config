#!/usr/bin/env sh

pdf_folder="$HOME/Documents/pdfs"
documents_folder="$HOME/Documents/"
video_folder="$HOME/Videos/"
picture_folder="$HOME/Pictures/"
iso_folder="$HOME/Other/iso/"
directory="$HOME/Downloads/"

# Create a file to store the timestamp of the last processed file
touch  $HOME/.local/share/lastwatch

while true
do
    sleep 3

    # Replace spaces with underscores in filenames within the Downloads directory
    find $directory -name "* *" -type f | while IFS= read -r file; do
        new_file=$(echo "$file" | tr ' ' '_')
        mv "$file" "$new_file"
    done

    # Find files in the Downloads directory that have been created or modified since the last run
    file_list=($(find -L $HOME/Downloads/ -type f -cnewer $HOME/.local/share/lastwatch))

    for file in "${file_list[@]}"; do

        if [ -z "$file" ]; then
            continue
        fi

        case "$file" in
            *.pdf)
                mv "$file" "$pdf_folder"
                ;;
            *.iso)
                mv "$file" "$iso_folder"
                ;;
            *.sh|*.md|*.txt|*.html)
                mv "$file" "$documents_folder"
                ;;
            *.mkv|*.mp4|*.webm)
                mv "$file" "$video_folder"
                ;;
            *.jpg|*.webp|*.jpeg|*.png)
                mv "$file" "$picture_folder"
                ;;
            *)
                notify-send -u critical "Error: Unknown file extension for file $(basename $file). Don't know where to move"
                ;;
        esac
    done
done
