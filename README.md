# Dell Inspiron 759x

<p>
	<img style="border-radius: 8px" src="Assets/background.jpg">
</p>

## System configuration

| Model | MacBookPro15,3 | Version | 10.15.2 |
| :-------- | :--------------------------- | :------------- | :------------------ |
| Processor | Intel Core i5-9300H/i7-9750H | Graphics | UHD Graphics 630 |
| Memory | 2667MHz DDR4 8GB| OS Disk | Samsung 970Evo Plus |
| Audio | Realtek ALC295 | WiFi/Bluetooth | Intel Wifi 9560/AX200 |

## About build

### Not Working

+ Intel wifi card is developing, there are two version of kext:
  + Faked as an ethernet card: you can check [here](https://github.com/zxystd/itlwm)
  + Using like an wifi card: you can check the status [here](https://github.com/AppleIntelWifi/adapter)
  + Bluetooth kext can be found here: [IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware)
+ Thing may never work:
  - Discrete GPU (Disabled)
  - Fingerprint (Disabled)
  - Internal Microphone

### HDMI blinking at boot

> This will happen when using plug-in HDMI after bootup. This will be fixed after short sleep (about 1min) and never happen again until reboot

- You can fixed this by turn off **com.apple.driver.AppleHDAController** in `Kernel and Kext Patches` on Clover or `Kernel > Patch` on Opencore but **HDMI Audio** will be disabled

## For building

> This will pull all newest kext and build into zip files

- Clone this repo
- Run follow command: `python3 update.py --build`
- Get your build at Builds folder

## Installation

- Prepair an Mac installer in USB with bootloader you choice ( Use unibeast to create it )
- Replace EFI folder in USB EFI partition with this shipped EFI folder ( find the folder with name is `EFI` from zip file)
- Boot into USB and select MacOs installer
- After install success, run PostInstall/install.sh in terminal
- Then you need to mount EFI partition and replace it with USB's EFI
- After System EFI replaced by your EFI, Using Opencore Configurator, Clover Configurator or update script to change SMBIOS, generate your serial and MBL
- If you're using intel card, please use NullEthernet for fixing iMess and FaceTime
	- Change MAC in NullEthernet with your new created one, see below

### Fake ethernet

- Generate your MAC address in SSDT-RMNE if using NullEthernet
- You can make an MacAddress in [Mac generator online](https://www.browserling.com/tools/random-mac)
- Edit SSDT-RMNE.aml with MaciASL and replace MAC with your generated one
- Save as -> ACPI machine language (replace exited one)
- Add it to your bootloader:
  - Kext add in Kexts:
    + Copy kext to kexts/other if using clovere
    + Copy kext to Kexts and it into Kernel in config.plist (Use OpencoreConfigurator)
  - AML's file add to ACPI folder (Opencore need add to ACPI after copy SSDT file to ACPI, use OpencoreConfigurator)
- Reboot

### Sleep Wake

```shell
sudo pmset -a hibernatemode 0
sudo pmset -a autopoweroff 0
sudo pmset -a standby 0
sudo pmset -a proximitywake 0
sudo pmset -b tcpkeepalive 0 (optional)
```

> `-b` - Battery `-c` - AC Power `-a` - Both

Please uncheck all options (except `Prevent computer from sleeping...`, which is optional) in the `Energy Saver` panel.

### Display

If you are using FHD(1080p) display, you may want to enable font smoothing:

```
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

If your laptop display is 4K screen, you should set uiscale to :

```sh
python update.py --set uiscale=2
```

### Using DW1820a as wifi card

You have to do following changes to Device Properties:

> Change

```xml
<key>#PciRoot(0x0)/Pci(0x1c,0x0)/Pci(0x0,0x0)</key>
```

> Into

```xml
<key>PciRoot(0x0)/Pci(0x1c,0x0)/Pci(0x0,0x0)</key>
```

+ See [THE Solution:Dell DW1820A](https://www.tonymacx86.com/threads/the-solution-dell-dw1820a-broadcom-bcm94350zae-macos-15.288026/)
+ Other card you may need google for it



### NTFS Writing

Add `UUID=xxx none ntfs rw,auto,nobrowse` to `/etc/fstab`, **xxx** is the UUID of your NTFS partition.

If your NTFS partition has Windows installed, you need to run `powercfg -h off` in powershell in Windows to disable hibernation.

### Tap Delay

- Turn off `Smart zoom` to avoid two-finger tap delay.

> See [is-it-possible-to-get-rid-of-the-delay-between-right-clicking-and-seeing-the-context-menu](https://apple.stackexchange.com/a/218181)

## BIOS value unlock (Advanced User)

> Big thanks for @Leoing, who found all nessesary value

| Name | Address | Configable value | Default value |
| :----------- | :------ | :--------------- | :------------ |
| CFC-Lock | 0x6F0 | 0x1 or 0x0 | 0x1 |
| DGPU | 0x574 | 0x1 or 0x0 | 0x1 |
| Voltage Lock | 0x78C | 0x1 or 0x0 | 0x1 (1.6.0) |

You can follow [this](https://github.com/Azkali/GPD-P2-MAX-Hackintosh/issues/16#issuecomment-565882180) to change those value

> For Bios 1.6.0 `0x78C` need set to 0x0 so VoltageShift can be used

> You can use mine SmartCPU Script base on VoltageShift for controlling cpu power's usage: [SmartCPU](https://github.com/tctien342/smart-cpu)
<p>
	<img style="border-radius: 8px" src="https://github.com/tctien342/smart-cpu/raw/master/menu.png">
</p>

## Credits

- [acidanthera](https://github.com/acidanthera) for providing almost all kexts and drivers
- [alexandred](https://github.com/alexandred) for providing VoodooI2C
- [headkaze](https://github.com/headkaze) for providing the very useful [Hackintool](https://www.tonymacx86.com/threads/release-hackintool-v2-8-6.254559/)
- [daliansky](https://github.com/daliansky) for providing the awesome hotpatch guide [OC-little](https://github.com/daliansky/OC-little/) and the always up-to-date hackintosh solutions [XiaoMi-Pro-Hackintosh](https://github.com/daliansky/XiaoMi-Pro-Hackintosh) [黑果小兵的部落阁](https://blog.daliansky.net/)
- [RehabMan](https://github.com/RehabMan) for providing numbers of [hotpatches](https://github.com/RehabMan/OS-X-Clover-Laptop-Config/tree/master/hotpatch) and hotpatch guides
- [knnspeed](https://www.tonymacx86.com/threads/guide-dell-xps-15-9560-4k-touch-1tb-ssd-32gb-ram-100-adobergb.224486) for providing Combojack, well-explained hot patches and USB-C hotplug solution
- [bavariancake](https://github.com/bavariancake/XPS9570-macOS) and [LuletterSoul](https://github.com/LuletterSoul/Dell-XPS-15-9570-macOS-Mojave) for providing detailed installation guide and configuration for XPS15-9570
- And all other authors that mentioned or not mentioned in this repo
- [xxxza](https://github.com/xxxzc/xps15-9570-macos) this build is porter from his project, big thanks to him
