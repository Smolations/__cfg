## /* @function
#	@usage __flgs_config_update
#
#	@output true
#
#	@description
#	This function is used to update a user's config file with default
#	settings from the default config file when those settings are not
#	present in the user's current config file. It does this by comparing
#	versions of the file. The version of the defaults file is at the top
#	of the file and is compared against an flgs.config.version file
#	which is NOT under version control (this is crucial).
#	description@
#
#	@notes
#	- The larger the config file, the longer the update takes.
#	notes@
#
#	@dependencies
#	cfg/flgs.config
#	cfg/flgs.config.defaults
#	dependencies@
#
#	@todo
#	This function will not remove old settings from config. It needs
#	to be able to take an option that does this.
#	todo@
#
#	@file functions/1250.__flgs_config_update.sh
## */


function _cfg_update {
	# local function variables
	local line defaults_version current_version i
	declare -a keys new_settings

	touch "$flgitscripts_config_version"
	# Check for new config settings. Add them to user's current config.
	defaults_version=$(read line < "$flgitscripts_config_defaults"; echo ${line:2})
	current_version=$(read line < "$flgitscripts_config_version"; echo $line)
	[ "x${current_version}" = "x" ] && {
		echo "0" > "$flgitscripts_config_version"
		current_version=0
	}

	#echo "default: $defaults_version"
	#echo "current: $current_version"
	if [ $defaults_version -gt $current_version ]; then
		echo "${A}Updating${X} config (v${current_version} -> v${defaults_version})..."

		# go through current config and store values in array
		while read line; do
			keys[${#keys[@]}]="${line%%=*}="
		done < "$flgitscripts_config"

		# loop through each line of defaults and compare it to saved array
		while read line; do

			grep -q '^[a-zA-Z]' <<< $line && {
					# only look at lines NOT starting with a hash (#) or a space
					#echo "Searching for: ${line%%=*}"
					#echo "from: $line"
					#echo
					egrep -q "(^| )${line%%=*}=( |$)" <<< "${keys[@]}" || {
						#string not found
						new_settings[${#new_settings[@]}]="$line"
						echo ${A}"    Adding${X}: $line"${X}
					}
				# done
			}

		done < "$flgitscripts_config_defaults"

		# add on new values to config
		for (( i = 0; i < ${#new_settings[@]}; i++ )); do
			echo "${new_settings[i]}" >> "$flgitscripts_config"
		done

		# update version
		echo "${A}Updating${X} config version..."
		echo "$defaults_version" > "$flgitscripts_config_version"

		echo "Config update complete!"
	else
		echo "Config file up-to-date!"
	fi
}
