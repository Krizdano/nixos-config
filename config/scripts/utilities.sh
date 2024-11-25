#!/usr/bin/env bash

# Variables for various settings and files
dmenu='fuzzel -d'
menu="$dmenu -i -p"
bookmark_file='/persist/home/nixconfig/config/scripts/bookmarks'
screen='hyprctl dispatch dpms'
monitor='eDP-1'

# Connect to already paired bluetooth devices
connect_bluetooth() {
    device="$(bluetoothctl devices | $menu "Select Device" | awk -F ' ' '{print $2}')"
    notify-send "$(bluetoothctl connect $device | grep -i -m3 'connect' | tail -n1)"
}

# Opens a bookmarked URL from the bookmarks file
my_bookmarks() {
    bookmark_menu=$(awk -F' ' '{print $1}' "$bookmark_file" | $menu "Bookmarks")
    wtype $(grep $bookmark_menu "$bookmark_file" | awk -F' ' '{print $2}')
}

# Adds a new bookmark with a URL and name to the bookmarks file and commits it to a Git repository.
add_bookmark () {
    url=$($dmenu -l 0 -p "Enter url")
    name=$($dmenu -l 0 -p "Enter name")

    if [[ "d" != "d$url" ]] && [[ "d" != "d$name" ]]; then
        echo "$name   $url" >> ~/nixconfig/config/scripts/bookmarks
        pushd ~/nixconfig;
        git add ~/nixconfig/config/scripts/bookmarks
        git commit -m "added a new bookmark"
        git push
        popd
    fi
}

change_default_sink() {
    wpctl set-default "$(wpctl status | grep -A 3 Sinks | $menu "Sinks" | awk -F ' ' '{print $2}')"
}

play_videos() {
    find Videos/ -type f -printf "%f\n" | $menu "Videos" |
        xargs -I '{}' find ~/Videos/ -name {} | xargs mpv
}

power_menu() {
    chpower() {
        case "$1" in
            "")
            ;;
            Poweroff)
                exec systemctl poweroff
                ;;
            Reboot)
                exec systemctl reboot
                ;;
            Suspend)
                exec systemctl suspend
                ;;
            Hibernate)
                exec systemctl hibernate
                ;;
            lock)
                exec loginctl lock-session
                ;;
        esac
    }

    options="Poweroff\nReboot\nHibernate\nSuspend\nlock"
    chpower "$(printf "%b" "$options" | sort | $menu "Power Menu")"
}

bat_level() {
    while true; do
        bat_lvl=$(cat /sys/class/power_supply/BAT1/capacity)
        bat_stat=$(cat /sys/class/power_supply/BAT1/status)

        # Notify if battery level is low and discharging
        if [[ $bat_lvl -le 30 && $bat_stat == "Discharging" ]]; then
            notify-send --urgency=CRITICAL "Battery Low" "Level: ${bat_lvl}%"
            sleep 300

        # Notify if battery level is high and charging
        elif [[ $bat_lvl -ge 80 && $bat_stat == "Charging" ]]; then
            notify-send --urgency=CRITICAL "Unplug Your Charger" "Battery Level: ${bat_lvl}%"
            sleep 300
        else
            sleep 120
        fi
    done
}

flip_monitor () {
    monitor_state=`hyprctl monitors | grep transform | tail -n 1 | awk '{print $2}'`

    if [ $monitor_state -eq 0 ]; then
        hyprctl keyword monitor HDMI-A-1,transform,4
        hyprctl keyword monitor eDP-1,transform,4
    else
        hyprctl keyword monitor HDMI-A-1,preferred,auto,1,transform,0
        hyprctl keyword monitor eDP-1,preferred,auto,1,transform,0
    fi
}

toggle_auto_suspend () {
    if systemctl --user is-active --quiet hypridle.service; then
        systemctl --user stop hypridle.service
        notify-send "Disabled auto suspend"
    else
        systemctl --user start hypridle.service
        notify-send "Enabled auto suspend"
    fi
}

#!/usr/bin/env bash
connect_to_wifi () {
    SSID=$(nmcli -f SSID device wifi list --rescan yes | tail -n +2 | $dmenu -i)

    if [[ ! -z $SSID ]]; then
        nmcli device wifi connect $SSID
        while [ $? -eq 4 ]; # nmcli returns 4 if password is not provided or if the password is wrong
        do
            PASSWORD=$(dmenu -l 0 -p "Enter password")
            nmcli device wifi connect $SSID password $PASSWORD
        done

        if [ $? -eq 0 ]; then
            notify-send "connected to wifi"
            exit
        else
            notify-send "error: not connected to wifi"
            exit
        fi
    else
        notify-send "SSID not provided"
        exit
    fi
}

case "$1" in
    "") ;;
    connect_bluetooth)
        "$@"
        exit
        ;;
    my_bookmarks)
        "$@"
        exit
        ;;
    add_bookmark)
        "$@"
        ;;
    change_default_sink)
        "$@"
        exit
        ;;
    toggle_screen)
        "$@"
        exit
        ;;
    play_videos)
        "$@"
        exit
        ;;
    my_playlist)
        "$@"
        exit
        ;;
    power_menu)
        "$@"
        exit
        ;;
    youtube_mpv)
        "$@"
        exit
        ;;
    bat_level)
        "$@"
        exit
        ;;
    flip_monitor)
        "$@"
        exit
        ;;
    toggle_auto_suspend)
        "$@"
        exit
        ;;
    connect_to_wifi)
        "$@"
        exit
        ;;
    *)
        echo "Unkown function: $1()"
        exit 2
        ;;
esac
