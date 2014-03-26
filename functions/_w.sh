## /* @function
#   @usage _w <message>
#
#   @output true
#
#   @description
#   Output an warning-styled message.
#   description@
#
#   @file functions/_w.sh
## */
function _w {
    echo "${_W}__cfg:${_WHITE}  ${@}${_X}"
}
