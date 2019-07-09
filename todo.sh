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
    # this will result in ".*opt1.*|.*opt2.*|.*opt3.*, everything in uppercase
    regex=""
    for arg in "$@"
    do
        regex="${regex}|.*${arg^^}.*"
    done
    # remove leading "|", spaces need to be quoted
    regex="$(sed 's/ /\\ /g' <<< "${regex#|}")"

    # read ~/.todo line by line
    echo "Matched todo's:"
    while read -r line
    do
        [[ "${line^^}" =~ ${regex} ]] && echo -e "\t${line}"
    done < ~/.todo
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
