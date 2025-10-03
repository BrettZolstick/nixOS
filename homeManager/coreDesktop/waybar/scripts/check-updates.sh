#!/bin/bash

# Count official repo updates (yay uses pacman under the hood for this)
repo_updates=$(checkupdates 2>/dev/null | wc -l)

# Count AUR updates using yay
aur_updates=$(yay -Qua 2>/dev/null | wc -l)

# Combine both
total_updates=$((repo_updates + aur_updates))

# Output in JSON format for Waybar
if [ "$total_updates" -gt 100 ]; then
    echo "{\"text\": \"!!!!!!!!!!!!!!!!!  $total_updates\", \"tooltip\": \"$repo_updates repo, $aur_updates AUR\"}"
elif [ "$total_updates" -gt 50 ]; then
    echo "{\"text\": \"!!!  $total_updates\", \"tooltip\": \"$repo_updates repo, $aur_updates AUR\"}"
elif [ "$total_updates" -gt 0 ]; then
    echo "{\"text\": \" $total_updates\", \"tooltip\": \"$repo_updates repo, $aur_updates AUR\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"System up to date\"}"
fi
