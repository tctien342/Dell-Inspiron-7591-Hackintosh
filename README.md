# Dell Inspiron 7591

This build running on MacOs X

![Alt text](Background.jpg)

# I. Detail

    Version:    1
    Date:       22/10/2019
    Support:    All BIOS
    Changelogs:
        - Init first stable build
        - Currently tested in MacOs Mojave 10.14.6
    Status: Stable

# II. System specification

    1.Name:           Dell Inspiron 7591
    2.CPU:            Intel Core i5-9300H
    3.Graphic:        Intel UHD630
    4.Wifi:           Intel Dual Band Wireless-AC 9560 - with bluetooth ( Will be replaced soon )
    5.Card Reader:    Realtek Memory Card Reader 
    6.Camera:         DELL UVC HD
    7.Audio:          ALC295
    8.Touchpad:       ELAN I2C ( Dell Precision Trackpad )
    9.Bios Version:   1.4.0

# III. Thing will not able to use

    1. DGPU Nvidia 1050 (Disabled through ssdt)
    2. Fingerprint (Disabled through usb inject)
    3. Intel wifi card

# IV. Tested hardware
    + Speaker/Headphone work
    + Linein through headset work
    + Type C USB work (Thunderbolt not tested yet)
    + Type C HDMI work
    + HDMI Work
    + All usb port work
    + SD card reader work
    + Camera work
    + Trackpad smooth as F
    + Battery work
    + All function key expect above numpad work
    + Keyboard and numpad work normal
    + UHD630 work

# V. Benchmark
    + Cinebench R20: MC - 1810
    + Geekbench 5: MC - 4158, SC - 1031

# VI. Know problems

    1. Internal mic (Pls help me if you master of AppleHDA)
    2. Need more testing...

# VII. Important thing
    All kext below should not be updated, because it have been modified by me to run in this machine:
        + AppleALC.kext ( Verb changed to support ALC295 in 7591, layout 77 modified )
        + CPUFriendDataProvider.kext
        + CustomPeripheral.kext ( Fake apple device, change it if you have different devices )
        + VoodooPS2Controller.kext ( Fixed panic when work with voodooi2c )

# VIII. Step to install

    1. Prepair an Mac installer in USB with Clover added ( Use unibeast to create it )
    2. Replace EFI folder in USB EFI partition with this shipped EFI folder
    3. Boot into USB and select MacOs installer
    4. First boot Trackpad will not work, need and mouse connect through USB, Follow mac install instruction you can find it on tonymacx86 or other hackintosh forum
    5. After install success, boot into MacOS, run ComboJack Alc295/ComboJack_Installer/install.sh in terminal
    6. Use Kext Utility to rebuild kext then reboot
    7. This time trackpad and audio will working normally, then you need to use Clover EFI bootloader to install clover to EFI partition
    8. After install success, using Clover Configurator to mount your USB EFI partition then copy it to your System EFI.
    9. After System EFI replaced by your EFI, Using Clover Configurator to change SMBIOS, generate your serial and MBL
    10. Optional to fix iMessenger
        + Go to https://www.browserling.com/tools/random-mac an click GenerateIP and pick an Mac address
        + Put it into SSDT-RMNE.dsl like below and save as aml file then copy to ACPI/Patched in clover
    11. Login iCloud and iMessenger, enjoy MacOS
![Alt text](UpdateMac.png)

# IX. WIFI Replacement
## Using new card ( Not tested yet, because im currently using USB wifi )
    1. Replace your card wifi with DW1560/DW1820a (Or other if you can find better one)
    2. Copy all kext on Wifi/Bluetooth to EFI -> Clover -> Kext -> Other
    4. Reboot and enjoy
## Using usb wiki
    + Suggest Comfast cf-811ac 
    + Using https://github.com/chris1111/USB-Wireless-Utility to make it run in mojave and catalina

# X. Undervolt script
    + Goto here: https://github.com/sicreative/VoltageShift and download his binary and read his instruction
    + Currently value have tested with my 7591 9300H: -120 -90 -120 (cpu gpu cache)

# Thanks
    + @bavariancake [https://github.com/bavariancake/XPS9570-macOS]
    + @sicreative [https://github.com/sicreative/VoltageShift]
    + @hackintosh-stuff [https://github.com/hackintosh-stuff/ComboJack]
    + @LuletterSoul [https://github.com/LuletterSoul/Dell-XPS-15-9570-macOS-Mojave]
    + @chris1111 [https://github.com/chris1111/USB-Wireless-Utility]