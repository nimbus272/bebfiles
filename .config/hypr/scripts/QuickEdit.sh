#!/bin/bash
# Rofi menu for Quick Edit/View of Settings (SUPER E)

# Define preferred text editor and terminal
edit=${EDITOR:-nano}
tty=wezterm

# Paths to configuration directories
configs="$HOME/.config/hypr/configs"
rofi_theme="~/.config/rofi/config-edit.rasi"
msg=' ⁉️ Choose which config to View or Edit ⁉️'

# Function to display the menu options
menu() {
	cat <<EOF
1. ENV variables
2. Window Rules
3. Monitors
4. User Keybinds
5. User Settings
6. Startup Apps
7. Decorations
8. Animations
9. Workspace Rules
EOF
}

# Main function to handle menu selection
main() {
	choice=$(menu | rofi -i -dmenu -config $rofi_theme -mesg "$msg" | cut -d. -f1)

	# Map choices to corresponding files
	case $choice in
	1) file="$configs/envVariables.conf" ;;
	2) file="$configs/windowRules.conf" ;;
	3) file="$configs/monitors.conf" ;;
	4) file="$configs/keybinds.conf" ;;
	5) file="$configs/settings.conf" ;;
	6) file="$configs/startupApps.conf" ;;
	7) file="$configs/decorations.conf" ;;
	8) file="$configs/animations.conf" ;;
	9) file="$configs/workspaceRules.conf" ;;
	*) return ;; # Do nothing for invalid choices
	esac

	# Open the selected file in the terminal with the text editor
	$tty start --always-new-process -- $edit "$file"
}

# Check if rofi is already running
if pidof rofi >/dev/null; then
	pkill rofi
fi

main
