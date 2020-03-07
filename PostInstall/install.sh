#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    exec sudo /bin/bash "$0" "$@"
fi
echo "<> Installing AudioFix..."

cd "$(dirname "${BASH_SOURCE[0]}")"
# Clean legacy stuff
#
sudo launchctl unload /Library/LaunchDaemons/com.XPS.ComboJack.plist 2>/dev/null
sudo rm -rf /Library/Extensions/CodecCommander.kext
sudo rm -f /usr/local/bin/ALCPlugFix
sudo rm -f /Library/LaunchAgents/good.win.ALCPlugFix
sudo rm -f /Library/LaunchDaemons/good.win.ALCPlugFix
sudo rm -f /usr/local/sbin/hda-verb
sudo rm -f /usr/local/share/ComboJack/Headphone.icns
sudo rm -f /usr/local/share/ComboJack/l10n.json

# install
mkdir -p /usr/local/sbin
sudo cp ComboJack /usr/local/sbin
sudo chmod 755 /usr/local/sbin/ComboJack
sudo chown root:wheel /usr/local/sbin/ComboJack
sudo cp hda-verb /usr/local/sbin
sudo mkdir -p /usr/local/share/ComboJack/
sudo cp Headphone.icns /usr/local/share/ComboJack/
sudo chmod 644 /usr/local/share/ComboJack/Headphone.icns
sudo cp l10n.json /usr/local/share/ComboJack/
sudo chmod 644 /usr/local/share/ComboJack/l10n.json
sudo cp com.XPS.ComboJack.plist /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/com.XPS.ComboJack.plist
sudo chown root:wheel /Library/LaunchDaemons/com.XPS.ComboJack.plist
sudo launchctl load /Library/LaunchDaemons/com.XPS.ComboJack.plist

echo "<> Installing SleepFix..."
sudo pmset -a tcpkeepalive 0
sudo pmset -a powernap 0
sudo pmset -a proximitywake 0

echo "<> Rebuild kext..."
sudo spctl --master-disable
sudo mount -uw /
sudo killall Finder
sudo chown -v -R root:wheel /System/Library/Extensions
sudo touch /System/Library/Extensions
sudo chmod -v -R 755 /Library/Extensions
sudo chown -v -R root:wheel /Library/Extensions
sudo touch /Library/Extensions
sudo kextcache -i /

echo "<> Done, please reboot your macos!"
exit 0
