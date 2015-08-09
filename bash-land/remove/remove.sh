#
# remove positional parameters in bash
#

# remove: create a <code>eval set -- $(remove #1 #2 #3)</code> operation to remove one or more positional parameters at any
#         place in the sequence
#
# parameters:
#
#   1: total number of positional parameters (defaults to 0)
#   2: position from which to remove (defaults to 2)
#   3: number of parameters to remove (defaults to 1)
#
remove() {

    # number of parameters is smaller 1 - nothing to remove
    if [ "${1:-0}" -lt "1" ]; then
        return
    fi

    # changes would be beyond parameters - unchanged
    if [ "${2:-2}" -gt "${1}" ]; then
        echo '"${@}"'
        return
    fi

    # number of changes is smaller 1 - unchanged
    if [ "${3:-1}" -le "0" ]; then
        echo '"${@}"'
        return
    fi

    local buffer=""
    local start_len=$((${2:-2} - 1))
    local end_at=$((${2:-2} + ${3:-1}))
    local end_len=$((${1} - end_at + 1))

    # check if there is a segment starting at position 1
    if [ "${start_len}" -gt "0" ]; then
        buffer='"${@:1:'"${start_len}"'}"'
    fi

    # check if there is a segment after those that were removed
    if [ "${end_len}" -gt "0" ]; then
        if [ ! -z "${buffer}" ]; then
            buffer+=" "
        fi
        buffer+='"${@:'"${end_at}"':'"${end_len}"'}"'
    fi

    echo "${buffer}"
}
