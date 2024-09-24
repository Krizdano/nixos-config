#!/usr/bin/env zsh

bar_color="#b3cfa7"
volume_step=1

# Uses regex to get volume from wpctl
function get_volume {
    float=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F': ' '{print $2}' | sed 's/\[MUTED\]//')
    echo $((float*100)) | sed 's/\.//'
}

# Uses regex to get mute status from wpctl
function get_mute {
    wpctl get-mute @DEFAULT_AUDIO_SINK@
}

# Returns a mute icon, a volume-low icon, or a volume-high icon, depending on the volume
function get_volume_icon {
    volume=`get_volume`
    echo $volume
    mute=`get_mute`
    if [ $volume -eq 0 ] ; then
        volume_icon=""
    elif [ $volume -lt 50 ]; then
        volume_icon=""
    else
        volume_icon=""
    fi
}

# Displays a volume notification using dunstify
function show_volume_notif {
    volume=`get_volume`
    get_volume_icon
    dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "$volume_icon $volume%" -h int:value:$volume -h string:hlcolor:$bar_color
}

case $1 in
    volume_up)
        # Unmutes and increases volume, then displays the notification
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume_step%+
        show_volume_notif
        ;;

    volume_down)
        # Raises volume and displays the notification
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume_step%-
        show_volume_notif
        ;;

    volume_mute)
        # Toggles mute and displays the notification
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        show_volume_notif
        ;;
esac
