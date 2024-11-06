#!/usr/bin/env bash
args=($@)
impure_flag=0
run_flag=0
options_flag=0
flake_url="nixpkgs#"
delimiter="--"

get_options() {
    delimiter_index=$((${#args[@]} - 1))
    for element in "${!args[@]}"; do
        if [[ "${args[element]}" == $delimiter ]]; then
            delimiter_index=$i
        fi
    done

    options=("${args[@]:$((delimiter_index+1))}")

    if [ $options_flag -eq 1 ]; then
        echo "${options[@]}"
    else
        echo "-- ${options[@]}"
    fi
}

get_packages() {
    packages=()
    for pkg in "${args[@]}"; do
        if [[ ! "$pkg" == -* ]]; then
            packages+=("$pkg")
        fi
    done

    if [ $run_flag -eq 1 ]; then
        packages[0]="$flake_url${packages[0]}"
    else
        for i in "${!packages[@]}"; do
            packages[i]="$flake_url${packages[i]}"
        done
    fi

    echo ${packages[@]}
}


run_command() {
    if [ $impure_flag -eq 1 ]; then
        export NIXPKGS_ALLOW_UNFREE=1;
        nix $sub_command $(get_packages) --impure $(get_options)
        export NIXPKGS_ALLOW_UNFREE=0;
        exit
    else
        nix $sub_command $(get_packages) $(get_options)
        exit
    fi
}

nix_shell() {
    sub_command="shell"
    run_command
}

nix_run() {
    sub_command="run"
    run_flag=1
    run_command
}

while getopts 'g:i:o' options; do
    case "$options" in
        g)
            flake_url="github:"
            ;;
        i)
            impure_flag=1
            ;;
        o)
            delimiter="-o"
            options_flag=1
            ;;
    esac
done
