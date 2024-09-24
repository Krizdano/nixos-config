#!/usr/bin/env sh

# Process command-line options
while getopts 'lsqo' option; do
    case "$option" in
        l)
            git clone "https://gitlab.com/$2" $3
            exit
            ;;
        s)
            git clone "https://sourcehut.org/$2" $3
            exit
            ;;
        q)
            query="$2"
            echo "searching for repo $2..."
            repo=`gh search repos $query | fzf --sync | awk '{print $1}'`
            git clone "git@github.com:$repo" $3
            exit
            ;;
        o)
            git clone "https://github.com/$2" $3
            exit
            ;;
    esac
done

# Default action if no options are provided
git clone "git@github.com:$1" $2
