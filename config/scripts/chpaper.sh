#!/usr/bin/env bash

wpname=`shuf -i 1-13 -n 1` # Generate a random number between 1 and 13 to select a wallpaper
wallpaper_url='https://raw.githubusercontent.com/Krizdano/wallpapers/main/images/'$wpname'.png'
wallpaper='/tmp/wallpaper.png'
backup_wallpaper='Pictures/.backup_wallpaper.png'

# Check if the internet connection is available by pinging a reliable host
if ping -q -w 1 -c 1 https://raw.githubusercontent.com > /dev/null; then
    curl --silent --output $wallpaper $wallpaper_url  # Download the wallpaper from the URL if online
    cp $wallpaper $backup_wallpaper
    swaybg -i $wallpaper
else
    # Use the backup wallpaper if offline
    swaybg -i $backup_wallpaper
fi
