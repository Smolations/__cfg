## /* @function
 #  @usage _cfg_exists
 #
 #  @output true (on error)
 #
 #  @description
 #  Shortcut for testing that the cfg file exists and is non-empty.
 #  description@
 #
 #  @notes
 #  - Meant for use in conditionals.
 #  - To prevent any weird recursion issues, the folder hierarchy crawl aborts
 #  if the number of levels exceeds a given limit.
 #  notes@
 #
 #  @examples
 #  # get the value associated with "mykey" in the config file
 #  _cfg_exists && myvar=`_cfg_get mykey`
 #  examples@
 #
 #  @dependencies
 #  functions/_er.sh
 #  functions/_set_cfg_vars.sh
 #  dependencies@
 #
 #  @returns
 #  0 - cfg found
 #  1 - too many directory levels to traverse
 #  2 - no cfg found
 #  returns@
 #
 #  @file functions/__cfg_exists.sh
 ## */

function _cfg_exists {
    local ret cfg_dir cur_dir=$(pwd) i=20

    while [ -n "$cur_dir" ] && (( i > 0 )); do
        # echo "${i}: ${cur_dir}"
        [ -d "${cur_dir}/${CFG_DIR_NAME}" ] && break
        cur_dir="${cur_dir%\/*}"
        (( i-- ))
    done

    if (( i == 0 )); then
        # cant be more than 30 levels deep
        _er "this directory structure is more than ${i} levels deep."
        ret=1

    elif [ -z "$cur_dir" ]; then
        # no cfg found
        _set_cfg_vars "$(pwd)"
        ret=2

    else
        # we've got a cfg!
        _set_cfg_vars "${cur_dir}"
        ret=0
    fi

    return $ret
}
export -f _cfg_exists
