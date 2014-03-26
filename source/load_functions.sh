## /*
#   @description
#   This file is to be sourced to load all functions into the calling
#   context.
#   description@
#
#   @file load-functions.sh
## */
for file in "${CFG_FN_PATH}/"*; do
    if [ ! -d "$file" ] && [ -s "$file" ]; then
        # echo "Going to source: ${file}"
        source "$file"
    fi
done
