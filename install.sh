# Setup FLGitScripts Home
if [ "x${__cfg_path}" = "x" ]; then
    # determine the path to this script. it will become the __cfg home path. the cfg directory
    # must live in the same directory as this script for any user overrides to take effect.
    THIS_SCRIPT_PATH="${BASH_SOURCE[0]}"
    if [ -h "${THIS_SCRIPT_PATH}" ]; then
        while [ -h "${THIS_SCRIPT_PATH}" ]; do
            THIS_SCRIPT_PATH=`readlink "${THIS_SCRIPT_PATH}"`
        done
    fi
    pushd . > /dev/null
    cd `dirname ${THIS_SCRIPT_PATH}` > /dev/null
    export THIS_SCRIPT_PATH=`pwd`;
    __cfg_path="${THIS_SCRIPT_PATH}"
    popd  > /dev/null
fi
export __cfg_path

# set up some shortcuts to call files since aliases aren't in place yet
source "${__cfg_path}/source/environment.sh"



# __cfg project new <label>
# __cfg project rm <label>
# __cfg project activate <label>


# __cfg [projectname] set/get/etc
#     - omitting project name will use the default project
