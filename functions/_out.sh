## /* @function
 #  @usage _out <message>
 #
 #  @output true
 #
 #  @description
 #  Output an info-styled message.
 #  description@
 #
 #  @file functions/_out.sh
 ## */

function _out {
    echo "${_O}__cfg:${_WHITE}  ${@}${_X}"
}
export -f _out
