#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
#
# diverse test and tries in building remove()
#

print_all()
{
    local i=0
    echo "parameters ($#)"
    for point; do
        ((i = i + 1))
        echo " # ${i}: '${point}'"
    done
}

set -- "a f" "b" "c"
print_all "${@}"

# set from string - fails w/o eval
test='"a f" "b" "c"'
eval set -- "${test}"
print_all "${@}"

# set from function echo - fails w/o eval
test_echo() {
    echo '"a f" "b" "c"'
}
eval set -- "$(test_echo)"
print_all "${@}"


# manipulate within function
test_edit() {
    >&2 echo -n "edit: "
    >&2 print_all "${@}"
    # echo '"${@:2:1}"'
    echo '"${@:1:1}" "${@:3:1}"'
}
eval set -- "$(test_edit "${@}")"
print_all "${@}"
