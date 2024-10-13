#!/usr/bin/env bash
script_path=${0%/*}
source $script_path/include/main.sh
nix_shell
