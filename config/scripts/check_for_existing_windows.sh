#!/usr/bin/env bash

# urls for different tabs
youtube_url='firefox -new-tab https://www.youtube.com'
nixpkgs_url='firefox -new-tab https://search.nixos.org/packages'
hm_url='firefox -new-tab https://home-manager-options.extranix.com'

# Command to switch to the 'browser' workspace
browser_workspace='hyprctl dispatch workspace name:browser'

browser ()
{
    if pgrep "firefox" > /dev/null
    then
        $browser_workspace
    else
        firefox & disown
    fi
}

youtube_in_browser ()
{
    if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
        $youtube_url # Open YouTube in a new tab if already in 'browser' workspace
    else
        $browser_workspace # Switch to 'browser' workspace
        $youtube_url # Open YouTube search in a new tab
    fi
}

nixpkgs_search ()
{
    if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
        $nixpkgs_url # Open Nixpkgs search in a new tab if already in 'browser' workspace
    else
        $browser_workspace # Switch to 'browser' workspace
        $nixpkgs_url # Open Nixpkgs search in a new tab
    fi
}

home_manager_search ()
{
    if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
        $hm_url # Open Home Manager options in a new tab if already in 'browser' workspace
    else
        $browser_workspace # Switch to 'browser' workspace
        $hm_url # Open Home Manager options in a new tab
    fi
}

terminal ()
{
    if pgrep "emacsclient" > /dev/null # Check if Emacs client is running
    then
        hyprctl dispatch togglespecialworkspace terminal # Toggle the terminal workspace if Emacs client is running
    else
        emacsclient -c -e "(vterm)" & disown # Start Emacs client with a terminal and run in the background
        hyprctl dispatch togglespecialworkspace terminal # Toggle the terminal workspace
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
