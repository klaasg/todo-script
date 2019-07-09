#!/bin/bash

# there is a function for every action: list, add and remove

function list {
    echo "list $@"
}

function add {
    echo "add $@"
}

function remove {
    echo "remove $@"
}

# basic function to display usage and help

function usage {
    # display usage
    echo "usage"
}

function help {
    # display help
    echo "help"
}

# no use of getopts because it's very simple

case $1 in
    --help|-h)
        help
    ;;
    add|--add|-a)
        shift
        add "$@"
    ;;
    remove|--remove|-r)
        shift
        remove "$@"
    ;;
    *)
        list "$@"
    ;;
esac
