special_flag=0

switch_workspace() {
    workspace=$1
    if [ ! -z $HYPRLAND_INSTANCE_SIGNATURE ]; then # Check if we are on Hyprland
        if [ $special_flag -eq 1 ]; then
        hyprctl dispatch togglespecialworkspace $workspace # Toggle special workspaces
        else
            hyprctl dispatch workspace name:$workspace # Switch to normal workspaces
        fi
    elif [ ! -z $NIRI_SOCKET ]; then # Check if we are on Niri
        niri msg action focus-workspace $workspace
    fi
}

#!/usr/bin/env bash

# urls for different tabs
youtube_url='firefox -new-tab https://www.youtube.com'
nixpkgs_url='firefox -new-tab https://search.nixos.org/packages'
hm_url='firefox -new-tab https://home-manager-options.extranix.com'

browser ()
{
    if pgrep "firefox" > /dev/null
    then
        switch_workspace Browser
    else
        firefox & disown
        switch_workspace Browser
    fi
}

youtube_in_browser ()
{
    if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
        $youtube_url # Open YouTube in a new tab if already in 'browser' workspace
    else
        switch_workspace Browser
        $youtube_url # Open YouTube search in a new tab
    fi
}

nixpkgs_search ()
{
    if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
        $nixpkgs_url # Open Nixpkgs search in a new tab if already in 'browser' workspace
    else
        switch_workspace Browser
        $nixpkgs_url # Open Nixpkgs search in a new tab
    fi
}

home_manager_search ()
{
    if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
        $hm_url # Open Home Manager options in a new tab if already in 'browser' workspace
    else
        switch_workspace Browser
        $hm_url # Open Home Manager options in a new tab
    fi
}

terminal ()
{
    special_flag=1
    if pgrep "emacsclient" > /dev/null # Check if Emacs client is running
    then
        switch_workspace Terminal
    else
        emacsclient -c -e "(vterm)" & disown # Start Emacs client with a terminal and run in the background
        switch_workspace Terminal
    fi
}

case "$1" in
    "") ;;  # No argument, do nothing
    browser) "$@"; exit;;  # Call the 'browser' function
    terminal) "$@"; exit;;  # Call the 'terminal' function
    youtube_in_browser) "$@"; exit;;  # Call the 'youtube_in_browser' function
    nixpkgs_search) "$@"; exit;;  # Call the 'nixpkgs_search' function
    home_manager_search) "$@"; exit;;  # Call the 'home_manager_search' function
    *) echo "Unknown function: $1()"; exit 2;;  # Print error message for unknown functions
esac
