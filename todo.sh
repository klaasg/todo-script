#!/bin/bash

# there is a function for every action: list, add and remove

function list {

}

function add {

}

function remove {

}

# basic function to display usage and help

function usage {
    # display usage
}

function help {
    # display help
}

# no use of getopts because it's very simple

case $1 in
    --help|-h)
        help
    ;;
    add|--add|-a)
        shift
        add
    ;;
    remove|--remove|-r)
        shift
        remove
    ;;
    *)
        list
    ;;
esac
