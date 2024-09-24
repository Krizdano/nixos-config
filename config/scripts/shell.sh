#!/usr/bin/env sh

args=$*
counter=1

total_args=$(echo "$args" | wc -w)
flake_url="nixpkgs#"

while getopts 'gi' options; do
    case "$options" in
        g)
            nix shell "github:$2"
            exit
            ;;
        i)
            export NIXPKGS_ALLOW_UNFREE=1;
            nix shell "flake_url$2" --impure;
            export NIXPKGS_ALLOW_UNFREE=0;
            exit
            ;;

    esac
done

packages=$(while (( counter <= total_args )); do
               echo -n "$flake_url""$(echo $args | awk '{print $'$counter'}') "
               ((counter++));
           done)

nix shell $packages
