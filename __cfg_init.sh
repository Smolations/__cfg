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


# set environment variables
source "${__cfg_path}/source/environment.sh"

# load functions
source "${cfg_src_path}/load_functions.sh"

# create tmp directory if it doesn't exist
[ ! -d "${cfg_tmp_path}" ] && mkdir "${cfg_tmp_path}"

echo "${__cfg_path}/"



# set some initial info for __cfg's cfg
# __cfg __cfg set paths.cfg.install "${__cfg_path}"

# parse each config file
# for file in "${cfg_cfg_path}/"*; do


# __cfg project new <label>
# __cfg project rm <label>
# __cfg project activate <label>


# __cfg [projectname] set/get/etc
#     - omitting project name will use the default project
