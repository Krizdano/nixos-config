#!usr/bin/env sh

# Create a file to store the timestamp of the last processed file
touch  $HOME/.local/share/lastwatch
cd $HOME
while true
do
    sleep 3

    # Replace spaces with underscores in filenames within the Downloads directory
    find Downloads/ -name "* *" -type f | rename 's/ /_/g'

    # Find files in the Downloads directory that have been created or modified since the last run
    file=$(find -L $HOME/Downloads/ -type f -cnewer $HOME/.local/share/lastwatch | awk '{print $1}')

    # Extract the file path from the result (in case there's more than one result)
    file=$(echo $file | awk '{print $1}')

    if [[ $file =~ .*\.(sh|md|txt|pdf|html) ]]; then
        if [[ $file == *.pdf ]]; then
            mv $file $HOME/Documents/pdfs/

        else
            mv $file $HOME/Documents/

        fi

    elif [[ $file =~ .*\.(mkv|mp4)  ]]; then
        mv $file $HOME/Videos/

    elif [[ $file =~ .*\.(jpg|webp|jpeg|png) ]]; then
        mv $file $HOME/Pictures/

    elif [[ $file =~ .*\.(ipynb) ]]; then
        mv $file $HOME/projects/python/jupyter/

    elif [[ $file =~ .*\.(iso) ]]; then
        mv $file $HOME/Other/iso

    # Handle files with unknown or unhandled extensions
    elif [[ $(echo $file | awk -F '/' '{print $4}') == "Downloads" || $file == *"."* ]]; then
        notify-send -u critical "Error: Unknown file extension for file '$(echo $file | awk -F '/' '{print $5}')'. Don't know where to move"
        sleep 20
    fi
done
