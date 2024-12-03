dmenu='fuzzel -d'
exec_command() {
    if [ ! -z $HYPRLAND_INSTANCE_SIGNATURE ]; then # Check if we are on Hyprland
        if [ $all_monitors -eq 1 ]; then
            hyprctl dpms $1
            exit
        else
            hyprctl dispatch dpms $1 eDP-1
        fi
    elif [ ! -z $NIRI_SOCKET ]; then # Check if we are on Niri
        if [ $all_monitors -eq 1 ] && [ $1 == "off" ]; then
            niri msg action power-off-monitors
            exit
        elif [ $all_monitors -eq 1 ] && [ $1 == "on" ]; then
            exit
        else
            niri msg output edp-1 $1
        fi
    fi
}

action() {
    case "$1" in
        "") ;;
        Screenoff)
            exec_command off
            ;;
        Screenon)
            exec_command on
            echo "hello"
            ;;
    esac
}

while getopts 'mn' option; do
    options="Screenoff\nScreenon"
    case "$option" in
        m)
            all_monitors=0
            action "$(printf "%b" "$options" | sort | $dmenu -i -p "Screen ")"
            exit
            ;;
        n)
            all_monitors=1
            action $2
            exit
            ;;
    esac
done
