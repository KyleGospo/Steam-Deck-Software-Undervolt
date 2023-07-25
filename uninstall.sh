#!/bin/sh
set -eu

# Check for root privileges
if [ "$(id -u)" != "0" ]
then
    echo "This script must be run with root privileges"
    exit 1
fi

# Uninstall files etc.
echo "Disable set-ryzenadj-tweaks service..."
systemctl disable set-ryzenadj-tweaks.service

echo "Disable path listener..."
systemctl disable set-ryzenadj-tweaks.path

echo "Removing files..."
remPath="/home/deck/.local/bin/"
rm $remPath"allowadj.txt"
rm $remPath"experimental.sh"
rm $remPath"experimentaladj.txt"
rm $remPath"off.sh"
rm $remPath"on.sh"
rm $remPath"ryzenadj"
rm $remPath"set-ryzenadj-tweaks.sh"
rm $remPath"statusadj.txt"

remPath="/etc/systemd/system/"
rm $remPath"ac.target"
rm $remPath"battery.target"
rm $remPath"set-ryzenadj-tweaks.path"
rm $remPath"set-ryzenadj-tweaks.service"

remPath="/etc/udev/rules.d/"
rm $remPath"99-powertargets.rules"

echo "Disable new powertarget rules..."
udevadm control --reload-rules

echo "Uninstall complete."
