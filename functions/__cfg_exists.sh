## /*
#   @usage __cfg_exists
#
#   @output false
#
#   @description
#   Shortcut for testing that the cfg file exists and is non-empty.
#   description@
#
#   @notes
#   - Meant for use in conditionals.
#   notes@
#
#   @examples
#   # get the value associated with "mykey" in the config file
#   __cfg_exists && myvar=`__cfg get mykey`
#   examples@
#
#   @file functions/__cfg_exists.sh
## */
function __cfg_exists {
    local ret cfg_dir cur_dir=$(pwd) i=20

    while [ -n "$cur_dir" ] && (( i > 0 )); do
        # echo "${i}: ${cur_dir}"
        cur_dir="${cur_dir%\/*}"
        (( i-- ))
    done

    if (( i == 0 )); then
        # cant be more than 30 levels deep
        __er "this directory structure is more than ${i} levels deep."
        ret=1

    elif [ -z "$cur_dir" ]; then
        # no cfg found
        # __er "no cfg found."
        ret=2

    else
        # we've got a cfg!
        export __CFG_DIR="$cur_dir"
        __out "cfg found!  ${__CFG_DIR}"
        ret=0
    fi

    return $ret
}
