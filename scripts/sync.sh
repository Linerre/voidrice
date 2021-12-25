#!/usr/bin/env sh

# Author: Errelin

# Use this script to update dotfiles on a local machine
# This script will copy all conf files under .config/*/
# to the corresponding dir under ~/.config/*/
# This method help avoids symlinks everywhere and keep $HOME clean

# Note:
# cp everything in $dir rather than $dir itself
# because ~/.config/$dir is not identical to ~dotfiles/.config/$program
# for example, plugins dir under ~/.config/ranger/ is not in dotfiles dir

# set two counter
existing_config=0
new_config=0

# loop over all configs under .config
for dir in .config/*; do
	program="$(basename $dir)"	
	if [ -d "$HOME/.config/$program" ]; then
		printf "%s %s\n" "$program" "config directory already exists; Overriding..."
		cp -f -r "$dir"/. "$HOME/.config/$program/"
		existing_config=$((existing_config+1))
	else
		printf "%s %s\n" "Need to copy over config for" "$program"
		mkdir "$HOME/.config/$program"
		cp -r "$dir"/. "$HOME/.config/$program/"
		new_config=$((new_config+1))
	fi
done

echo "config update done"
printf "%s%d\n" "Updated old configs in total: " "$existing_config" 
printf "%s%d\n" "Updated new configs in total: " "$new_config" 
unset existing_config new_config
exit 0

