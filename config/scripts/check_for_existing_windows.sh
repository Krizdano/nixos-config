#!/usr/bin/env bash

special_flag=0
on_hyprland=0
on_niri=0

check_wm () {
    if [ ! -z $HYPRLAND_INSTANCE_SIGNATURE ]; then # Check if we are on Hyprland
        on_hyprland=1
    elif [ ! -z $NIRI_SOCKET ]; then # Check if we are on Niri
        on_niri=1
    fi
}

special_flag=0
on_hyprland=0
on_niri=0

switch_workspace() {
    check_wm
    workspace=$1

    if [ $on_hyprland -eq 1 ]; then # Check if we are on Hyprland

        if [ $special_flag -eq 1 ]; then
            hyprctl dispatch togglespecialworkspace $workspace # Toggle special workspaces
        else
            hyprctl dispatch workspace name:$workspace # Switch to normal workspaces
        fi

    elif [ $on_niri -eq 1 ]; then # Check if we are on Niri
        niri msg action focus-workspace $workspace
    fi
}

check_workspace_and_run () {

    run_command=$@
    check_wm

    if [ $on_hyprland -eq 1 ]; then
        check_workspace=$(hyprctl activeworkspace | grep "browser" | awk '{print $4}')
        active_workspace="($workspace)"
    elif [ $on_niri -eq 1 ]; then
        check_workspace=$(niri msg workspaces | grep "*" | awk '{print $3}')
        active_workspace="\"$workspace"\"
    fi

    if [[ $check_workspace == $active_workspace ]]; then
        $run_command
    else
        switch_workspace $workspace
        $run_command
    fi

}

browser ()
{
    if pgrep "firefox" > /dev/null
    then
        switch_workspace Browser
    else
        workspace="Browser"
        check_workspace_and_run firefox & disown
    fi
}

youtube_in_browser () {
    youtube_url='firefox -new-tab https://www.youtube.com'
    workspace="Browser"

    check_workspace_and_run $youtube_url
}

nixpkgs_search () {
    workspace="Browser"
    nixpkgs_url='firefox -new-tab https://search.nixos.org/packages'

    check_workspace_and_run $nixpkgs_url
}

home_manager_search () {
    hm_url='firefox -new-tab https://home-manager-options.extranix.com'
    workspace="Browser"

    check_workspace_and_run $hm_url
}

terminal () {
    special_flag=1
    if pgrep "emacsclient" > /dev/null # Check if Emacs client is running
    then
        switch_workspace Terminal
    else
        workspace="Terminal"
        check_workspace_and_run alacritty --title=emacs --class=emacs -e emacsclient -nw -e "(vterm)"
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
