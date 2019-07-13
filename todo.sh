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

    line_number=1     # also keeping track of the line number, for possibly removing later
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
    [[ $# -eq 0 ]] || echo "$(wc -l ${found_file} | cut -d" " -f1) matche(s) found"
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
        echo -en "\t${todo}\n\t"
        read -r -p "Do you want to delete this todo? [Y/n] " answer </dev/tty

        if [[ "${answer,,}" =~ ^(y|yes)$ ]] || [[ -z "${answer}" ]]
        then
            removing="${removing}${line_number} "
        fi
    done < ${found_file}

    # now deleting with `sed -i '1d; 3d; ...' ~/.todo`
    removing=${removing// /d; }
    sed -i "${removing}" ~/.todo

    rm ${found_file}    # removing the temporary file
}

# basic function to display usage and help

function usage {
    # display usage
    cat <<USAGE
usage:  $(basename $0) [ arg ... ]"
            List all todo's that match with args
        $(basename $0) add|-a|--add [ arg ... ]
            Add all todo's with name 'arg'
        $(basename $0) remove|-r|--remove [ arg ... ]
            Remove, with confirmation, all todo's that match with arg
        When matching, no arguments match all todo's
USAGE

}

# no use of getopts because it's very simple

case $1 in
    --help|-h)
        usage
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
