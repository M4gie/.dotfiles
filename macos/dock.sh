#!/usr/bin/env bash

set -euo pipefail

add_to_dock() {
	local app_path="$1"

	if [ -d "$app_path" ]; then
		dockutil --no-restart --add "$app_path"
	else
		echo "Skipping missing app: $app_path"
	fi
}

dockutil --no-restart --remove all
add_to_dock "/Applications/Slack.app"
add_to_dock "/Applications/Discord.app"
add_to_dock "/Applications/Telegram.app"
add_to_dock "/Applications/Proton Pass.app"
add_to_dock "/Applications/Zen.app"
add_to_dock "/System/Applications/Calendar.app"
add_to_dock "/Applications/Obsidian.app"
add_to_dock "/Applications/Visual Studio Code.app"
add_to_dock "/Applications/Ghostty.app"
# add_to_dock "/System/Applications/Utilities/Terminal.app"
add_to_dock "/System/Applications/System Settings.app"

killall Dock >/dev/null 2>&1 || true

echo "Dock layout applied."