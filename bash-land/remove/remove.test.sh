#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
#
# test for remove
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

. remove.sh

set -- "a 'f" "b" "c"
echo 'debug: '$(remove 0 2 0)-
eval set -- $(remove 0 2 0)
echo "parameters ($#) - empty" # 0 here

set -- "a 'f" "b" "c"
echo 'debug: '$(remove $# 2 1)
eval set -- $(remove $# 2 1)
print_all "${@}"

set -- "a 'f" "b" "c"
echo 'debug: '$(remove $# 2 2)
eval set -- $(remove $# 2 2)
print_all "${@}"

set -- "a 'f" "b" "c"
echo 'debug: '$(remove $# 3 2)
eval set -- $(remove $# 3 2)
print_all "${@}"

set -- "a 'f" "b" "c"
echo 'debug: '$(remove $# 4 2)
eval set -- $(remove $# 4 2)
print_all "${@}"

set -- "a 'f" "b" "c"
echo 'debug: '$(remove $# 1 3)-
eval set -- $(remove $# 1 3)
echo "parameters ($#) - empty" # 0 here

set -- "a 'f" "b" "c"
echo 'debug: '$(remove $# 1 4)-
eval set -- $(remove $# 1 4)
echo "parameters ($#) - empty" # 0 here

set --
echo 'debug: '$(remove 0 2 0)-
eval set -- $(remove 0 2 0)
echo "parameters ($#) - empty" # 0 here

echo "----"

set --  "--no-git-gui" "-h"
echo 'debug: '$(remove 2 1)
eval set -- $(remove 2 1)
print_all "${@}"

set --  "--no-git-gui" "-h"
echo 'debug: '$(remove 2)
eval set -- $(remove 2)
print_all "${@}"

set --  "--no-git-gui" "-h"
echo 'debug: '$(remove)-
eval set -- $(remove)
echo "parameters ($#) - empty" # 0 here
