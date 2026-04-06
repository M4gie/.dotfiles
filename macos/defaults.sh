#!/usr/bin/env bash

set -euo pipefail

COMPUTER_NAME="Maji"
LANGUAGES=(en fr)
LOCALE="en_US@currency=EUR"
MEASUREMENT_UNITS="Centimeters"
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
defaults write NSGlobalDomain AppleMetricUnits -bool true

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
defaults write com.apple.iCal "first day of week" -int 1

echo "Disabling Safari password manager prompts and autofill..."
write_optional_default com.apple.Safari AutoFillPasswords -bool false
write_optional_default com.apple.Safari PasswordBreachDetectionOn -bool false
write_optional_default com.apple.Safari AutoFillFromAddressBook -bool false
write_optional_default com.apple.Safari AutoFillCreditCardData -bool false
write_optional_default com.apple.Safari AutoFillMiscellaneousForms -bool false
write_optional_default com.apple.Safari AutoFillWebForms -bool false

killall Dock >/dev/null 2>&1 || true
killall SystemUIServer >/dev/null 2>&1 || true
killall Finder >/dev/null 2>&1 || true

echo "macOS defaults applied."