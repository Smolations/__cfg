## /* @function
 #  @usage _cfg_search <key>
 #
 #  @output false
 #
 #  @description
 #  Searches the parsed cfg file for the existence of the given key. It does not matter
 #  whether or not the key has an associated value.
 #  description@
 #
 #  @notes
 #  - Intended for use with conditionals as return values are specified.
 #  notes@
 #
 #  @examples
 #  # some operations may include uploading/downloading via (s)ftp
 #  if _cfg_search ftp.user; then
 #      user=$(_cfg_get ftp.user)
 #      # interact with ftp...
 #  fi
 #  examples@
 #
 #  @dependencies
 #  `egrep`
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - no arguments passed to function
 #  returns@
 #
 #  @file functions/_cfg_search.sh
 ## */

function _cfg_search {
    [ -z "$1" ] && return 1

    local pattern
    pattern="^${1//[/\\[}="
    pattern="${pattern//]/\\]}"

    egrep -q "$pattern" "${__CFG_PARSED}"
}
export -f _cfg_search
