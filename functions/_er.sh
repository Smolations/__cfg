## /* @function
#   @usage _er <message>
#
#   @output true
#
#   @description
#   Output an error-styled message.
#   description@
#
#   @file functions/_er.sh
## */
function _er {
    echo "${_ER}__cfg ERROR:${_WHITE}  ${@}${_X}"
}
export -f _er
