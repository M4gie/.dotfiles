#!/usr/bin/env bash

set -euo pipefail

COMPUTER_NAME="Maji"
LANGUAGES=(en fr)
LOCALE="en_US@currency=EUR;fw=mon"
MEASUREMENT_UNITS="Centimeters"
TEMPERATURE_UNIT="Celsius"
SCREENSHOTS_FOLDER="${HOME}/Screenshots"

write_optional_default() {
	if ! defaults write "$@"; then
		echo "Warning: could not write defaults domain/key: $*" >&2
	fi
}

echo "Setting computer name..."
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

echo "Applying language and locale settings..."
defaults write NSGlobalDomain AppleLanguages -array "${LANGUAGES[@]}"
defaults write NSGlobalDomain AppleLocale -string "$LOCALE"
defaults write NSGlobalDomain AppleMeasurementUnits -string "$MEASUREMENT_UNITS"
defaults write NSGlobalDomain AppleTemperatureUnit -string "$TEMPERATURE_UNIT"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleFirstWeekday -dict gregorian 2

echo "Configuring menu bar and save behavior..."
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Disabling application quarantine dialog for downloaded apps..."
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "Setting screenshot folder..."
mkdir -p "$SCREENSHOTS_FOLDER"
defaults write com.apple.screencapture location -string "$SCREENSHOTS_FOLDER"

echo "Configuring Finder..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true

echo "Configuring Dock to auto-hide..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.8
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false

echo "Setting calendar week start to Monday..."
defaults write com.apple.iCal "first day of week" -int 2

###############################################################################
# Kill affected applications                                                  #
###############################################################################

apps=("Activity Monitor" "Calendar" "Contacts" "Dock" "Finder" "Messages" "Photos" "Safari" "SystemUIServer" "Terminal" "iCal" "Weather" "System Preferences" "System Settings")
for app in "${apps[@]}"; do
	killall "${app}" &> /dev/null || true
done

killall cfprefsd &> /dev/null || true

echo "macOS defaults applied."