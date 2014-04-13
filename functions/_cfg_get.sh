## /* @function
#   @usage _cfg_get
#
#   @output true
#
#   @description
#   Retrieve the value for a given key. If you want to be able to see the value with
#   any key tokens, pass the -o option.
#   description@
#
#   @options
#   -o, --original      Use __CFG_RAW instead of __CFG_PARSED.
#   options@
#
#   @examples
#   # assume:  my-key="@{mypath}/foo"
#   $ _cfg_get my-key
#       # -> /my/path/foo
#   $ _cfg_get -o my-key
#       # -> @{mypath}/foo
#   examples@
#
#   @file functions/_cfg_.sh
## */

function _cfg_get {
    local grepped file="${__CFG_PARSED}"

    if egrep -q "\\-o |\\-\\-original " <<< "$@"; then
        file="${__CFG_RAW}"
        shift
    fi

    grepped=$(egrep "^${1}=" "$file")
    echo "${grepped#*=}"
}
export -f _cfg_get
