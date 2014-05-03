## /* @function
 #  @usage _kill_tmp
 #
 #  @output false
 #
 #  @description
 #  Remove the current cfg's tmp file.
 #  description@
 #
 #  @file functions/_kill_tmp.sh
 ## */

function _kill_tmp {
    rm -f "$__CFG_TMP"
}
export -f _kill_tmp
