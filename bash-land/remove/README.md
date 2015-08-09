remove positional parameters
============================

a function that will echo a line of nothgin/a sequence/multiple sequences that represent the change of positional 
parameters when used with eval + set in the scope of use.

examples
--------

### remove a single parameter

    eval set -- $(remove $# 2)

removes one positional parameter at position two (`$2`).

if there are more than two parameters, those more than two will shift to fill the gap. if there were less than two 
parameters, either the sequence containing that one parameter (`"${@}"`) or if there are no parameters at all a 
no-sequence (`null` string) will be returned.
 

### remove multiple parameters

    eval set -- $(remove $# 3 2)

removes two parameters, the one at position three and the following one at position four (`$3` and `$4`).

in case the total number of original parameters was three, only the third parameter (`$3`) is removed. if there were 
five or more parameters, they will move into the hole the the removal caused. their order is not changed. if there were
less than three parameters, the parameters will be preseved as-is, that means either all parameters (`"${@}"`) or if 
there are no parameters at all a no-sequence (`null` string) will be returned and then eval'ed.


