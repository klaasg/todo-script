#!/bin/bash

# Is there a todo file?
if [[ ! -f ~/.todo ]]
then
    echo "There is no todo file."
    echo -e "Creating empty todo file ~/.todo\n"
    touch ~/.todo
fi

# there is a function for every action: list, add and remove

function list {
    # match with regex, all arguments should be possible, so "|"
    # this will result in "*opt1*|*opt2*|*opt3*
    regex="*$1*"
    shift
    for arg in "$@"
    do
        regex="${regex}|*${arg}*"
    done
    regex="${regex%|\*}"
    echo "${regex}"

    for line in ~/.todo
    do
        [[ "${line}" ~= "${regex}" ]]
    done
}

function add {
    for arg in "$@"
    do
        echo "Adding ${arg}"
        echo -e "$(date +"%d/%m/%Y %H:%M")\t${arg}" >> ~/.todo
    done
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
