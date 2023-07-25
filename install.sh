#!/bin/sh
set -eu

cp_file()
{
    cp "${1}${3}" "${2}${3}"
}


# Check for root privileges
if [ "$(id -u)" != "0" ]
then
    echo "This script must be run with root privileges"
    exit 1
fi

# Install files etc.
echo "Installing files..."
fromPath="./home/deck/.local/bin/"
toPath="/home/deck/.local/bin/"
mkdir -p $toPath
cp_file $fromPath $toPath "allowadj.txt"
cp_file $fromPath $toPath "experimental.sh"
cp_file $fromPath $toPath "experimentaladj.txt"
cp_file $fromPath $toPath "off.sh"
cp_file $fromPath $toPath "on.sh"
cp_file $fromPath $toPath "ryzenadj"
cp_file $fromPath $toPath "set-ryzenadj-tweaks.sh"
cp_file $fromPath $toPath "statusadj.txt"

fromPath="./etc/systemd/system/"
toPath="/etc/systemd/system/"
cp_file $fromPath $toPath "ac.target"
cp_file $fromPath $toPath "battery.target"
cp_file $fromPath $toPath "set-ryzenadj-tweaks.path"
cp_file $fromPath $toPath "set-ryzenadj-tweaks.service"

fromPath="./etc/udev/rules.d/"
toPath="/etc/udev/rules.d/"
cp_file $fromPath $toPath "99-powertargets.rules"

echo "Set permissions on files..."
toPath="/home/deck/.local/bin/"
chmod 666 $toPath"allowadj.txt"
chmod 666 $toPath"experimentaladj.txt"
chmod 755 $toPath"experimental.sh"
chmod 755 $toPath"on.sh"
chmod 755 $toPath"off.sh"

echo "Ensuring undervolt is off..."
bash $toPath"off.sh"

echo "Enable new powertarget rules..."
udevadm control --reload-rules

echo "Enable path listener..."
systemctl enable --now set-ryzenadj-tweaks.path

echo "Enabling set-ryzenadj-tweaks service..."
systemctl enable set-ryzenadj-tweaks.service

echo "Installation done."
echo ""
echo "Add on.sh, off.sh, and experimental.sh as non-steam"
echo "games and start testing undervolt settings in game mode."
echo "First try the on.sh script. It does a small -5 curve"
echo "offset. If it works fine you can try the experimental.sh"
echo "script. It does a much more ambitious -15 curve offset."
echo ""
echo "NOTE: It might cause a hard crash or a hang but you can"
echo "just restart your deck."
echo ""
echo "If the experimental setting also works fine you can edit"
echo "the undervolt settings in the 'experimental' and"
echo "'undervolt-on' sections of"
echo "/home/deck/.local/bin/set-ryzenadj-tweaks.sh"
echo "script moving the -15 curve offset to the 'undervolt-on'"
echo "section and making a more ambitous setting for the"
echo "'experimental' section, e.g., a -20 curve offset."
echo "If the experimental setting doesn't work you should go for"
echo "a less ambitious setting in the 'experimental' section,"
echo "eg., a -10 curve."
echo "In any case you can go back to game mode and test your new"
echo "experimental setting. Repeat until you find the best stable"
echo "setting and put that on the 'undervolt-on' section."
echo ""
echo "If something goes wrong and the deck hangs while applying"
echo "undervolt then all further undervolting attempts are"
echo "disabled. The file 'home/deck/.local/bin/statusadj.txt'"
echo "acts as a fail safe. It will contain the text"
echo "'Applying undervolt' after a failed restart. Make a less"
echo "ambitious undervolt setting and clear the contents of the"
echo "file to reactivate undervolting".
