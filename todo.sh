#!/bin/bash

# Is there a todo file?
if [[ ! -f ~/.todo ]]
then
    echo "There is no todo file."
    echo -e "Creating empty todo file ~/.todo\n"
    touch ~/.todo
fi

# find is for the list and remove functions to find todo's 

function find {
    # match with regex, all arguments should be possible, so "|"
    # this will result in ".*opt1.*|.*opt2.*|...|.*optN.*", everything in uppercase
    regex=""
    for arg in "$@"
    do
        # empty or whitespace arguments ruin the regex (first part checks that)
        [[ -z "${arg// /}" ]] || regex="${regex}|.*${arg^^}.*"
    done
    # remove leading "|", spaces need to be quoted
    regex="$(sed 's/ /\\ /g' <<< "${regex#|}")"

    # read ~/.todo line by line, save found todo's in file
    found_file=$(mktemp)

    line_number=0     # also keeping track of the line number, for possibly removing later
    while read -r date hour todo
    do
        [[ "${todo^^}" =~ ${regex} ]] && echo -e "${line_number}\t${todo}" >> ${found_file}
        ((line_number++))
    done < ~/.todo
}

# there is a function for every action: list, add and remove

function list {
    find "$@"

    # write out the matched todo's
    [[ $# -eq 0 ]] || echo "Matched todo's:"
    while read -r line_number todo
    do
        echo -e "\t${todo}"
    done < ${found_file}

    rm ${found_file}    # removing the temporary file
}

function add {
    for arg in "$@"
    do
        echo "Adding ${arg}"
        echo -e "$(date +"%d/%m/%Y %H:%M")\t${arg}" >> ~/.todo
    done
}

function remove {
    find "$@"

    # removing the found todo's with asking
    removing=""     # line numbers to remove
    while read -r line_number todo
    do
        echo -e "\t${todo}"
        read answer </dev/tty
        if [[ "${answer,,}" =~ ^(y|yes)$ ]] || [[ -z "${answer}" ]]
        then
            removing="${removing} ${line_number}"
        fi
    done < ${found_file}
    echo ${removing}

    rm ${found_file}    # removing the temporary file
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
