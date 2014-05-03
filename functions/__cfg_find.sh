## /* @function
 #  @usage __cfg_find [-v] <regex>
 #
 #  @output true
 #
 #  @description
 #  Searches the parsed cfg file for the existence of the <regex>. This function
 #  supports the extended regular expression syntax (same as `egrep`). The <regex>
 #  will be applied ONLY in the context of the individual keys (or values if the
 #  -v option is passed). See @examples related to the $ and ^ anchors.
 #  description@
 #
 #  @options
 #  -v      Apply the <regex> to each value instead of each key.
 #  options@
 #
 #  @examples
 #  ## sample cfg.cfg ##
 #  my.email=john@gmail.com
 #  my.number=555-123-4567
 #  my.number[0]=555-432-8765
 #  my.number[1]=555-928-3746
 #  ## /cfg.cfg ##
 #
 #  $ __cfg_find number
 #  my.number=555-123-4567
 #  my.number[0]=555-432-8765
 #  my.number[1]=555-928-3746
 #
 #  $ __cfg_find number$
 #  my.number=555-123-4567
 #
 #  $ __cfg_find -v 1
 #  my.number=555-123-4567
 #  my.number[1]=555-928-3746
 #
 #  $ for i in 0 1; do __cfg_find "number[${i}]"; done
 #  my.number[0]=555-432-8765
 #  my.number[1]=555-928-3746
 #  examples@
 #
 #  @dependencies
 #  `egrep`
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - no arguments passed to function
 #  2 - pattern for key contains an '=' character
 #  returns@
 #
 #  @file functions/__cfg_find.sh
 ## */

function __cfg_find {
    [ $# == 0 ] && return 1

    local searchKey=true pattern=

    if [ $# == 2 ] && [ "$1" == "-v" ]; then
        # search value
        searchKey=
        shift
    fi

    pattern="$@"

    if [ $searchKey ]; then
        if egrep -q '=' <<< "$pattern"; then
            _er "__cfg_find: input must not contain: ="
            return 2
        fi

        ! egrep -q '\^' <<< "$pattern" && pattern="^[^=]*${pattern}"
        egrep -q '\$' <<< "$pattern" && pattern="${pattern%$}=" || pattern="${pattern}[^=]*="

    else
        # key=^value$
        egrep -q '\^' <<< "$pattern" && pattern="^[^=]+=${pattern#^}" || pattern="^[^=]+=.*${pattern#^}"
        ! egrep -q '\$' <<< "$pattern" && pattern="${pattern}.*$"
    fi

    egrep "$pattern" "${__CFG_PARSED}"
}
export -f __cfg_find
