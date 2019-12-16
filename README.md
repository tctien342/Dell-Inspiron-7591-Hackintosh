# Dell Inspiron 7591

- This build running on MacOs X
- Tested in 10.14.6 and 10.15/10.15.1

<p>
    <img style="border-radius: 8px" src="Background.jpg">
</p>

# I. Detail

    Version:    3
    Date:       16/12/2019
    Support:    All BIOS
    Changelogs:
        - Update voodooI2C to newest, fix conflict with voodoops2
        - Update Combojack to with init patch
        - Fix LPC SSDT
        - Update ApplaALC to newest
        - Optimize some patch
        - Update all kext for better stability
    Status: Stable

### <strong>Important</strong>: 
+   Disable auto power up on lid in BIOS, if not you will get black screen on wake up by lid.
### <strong>For 4k screen</strong>:
+   Goto Config.plist -> Devices -> Properties -> PciRoot(0x0)/Pci(0x2,0x0)
+   Change dpcd-max-link-rate = <14000000>

# II. System specification

    1.Name:           Dell Inspiron 7591
    2.CPU:            Intel Core i5-9300H
    3.Graphic:        Intel UHD630
    4.Wifi/B:         Replaced with DW1820a
    5.Card Reader:    Realtek Memory Card Reader
    6.Camera:         DELL UVC HD
    7.Audio:          ALC295!
    8.Touchpad:       ELAN I2C ( Dell Precision Trackpad )
    9.Bios Version:   1.5.1

# III. Thing will not able to use

    1. DGPU Nvidia 1050 (Disabled through ssdt)
    2. Fingerprint (Disabled through usb inject)
    3. Intel wifi card

# IV. Tested hardware

    + Speaker/Headphone work
    + Linein through headset work
    + Type C USB work (Thunderbolt not tested yet)
    + Type C Graphic output work
    + ! HDMI work
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

    1. Internal mic (Pls help me if you master of AppleHDA, other linux it dead too)
    2. HDMI audio ( Need research more)
    2. Audio sometime not working if mac installed in fast NVME drive, due to AppleALC bug (Need research more...)

# VII. Important thing

    > All kext below should be updated from my git for this laptop:
        + AppleALC.kext ( Verb changed to support ALC295 in 7591, layout 13 modified to work with combojack )
            > Find it here: https://github.com/tctien342/AppleALC
            > Find Combojack here: https://github.com/tctien342/ComboJack
        + CustomPeripheral.kext ( Fake apple device, change it if you have different devices )
        + CPUFriendDataProvider.kext is for my 9300H, maybe it different for you, using https://github.com/stevezhengshiqi/one-key-cpufriend to regenerate it if your cpu is different.

    > After update or install MacOS: Please run rebuilt your kext ( Using Kext Utility or something can handle it ) for stablity.

# VIII. Step to install

    1. Prepair an Mac installer in USB with Clover added ( Use unibeast to create it )
    2. Replace EFI folder in USB EFI partition with this shipped EFI folder
    3. Boot into USB and select MacOs installer
    4. First boot Trackpad may not work, need and mouse connect through USB, Follow mac install instruction you can find it on tonymacx86 or other hackintosh forum
    5. After install success, boot into MacOS, run ComboJack Alc295/ComboJack_Installer/install.sh in terminal
    6. Use Kext Utility to rebuild kext then reboot
    7. This time trackpad and audio will working normally, then you need to use Clover EFI bootloader to install clover to EFI partition
    8. After install success, using Clover Configurator to mount your USB EFI partition then copy it to your System EFI.
    9. After System EFI replaced by your EFI, Using Clover Configurator to change SMBIOS, generate your serial and MBL
    10. Optional to fix iMessenger if you dont have compatible wifi card
        + Go to https://www.browserling.com/tools/random-mac an click GenerateIP and pick an Mac address
        + Put it into SSDT-RMNE.dsl in fake ethernet like below and save as aml file then copy to ACPI/Patched in clover
        + Copy NullEthernet.kext into your clover->kexts->other
        > Login iCloud and iMessenger, enjoy MacOS

<p>
    <img style="border-radius: 8px" src="UpdateMac.png">
</p>

# IX. WIFI Replacement

## Using new card ( DW1820A tested)

### Using DW1820a

    + Mine is CN-0VW3T3 0x106B:0x0021, not tested in other verizon yet
    + You need masked your pin like this: https://osxlatitude.com/forums/topic/11540-dw1820a-the-general-troubleshooting-thread/?do=findComment&comment=91179
    + Add flag below into boot flag
    + Add Devices below into Clover -> Devices -> Properties

```
    + PciRoot(0x0)/Pci(0x1d,0x6)/Pci(0x0,0x0)
        > AAPL,slot-name: WLAN
        > compatible: pci14e4,4353
        > device_type: Airport Extreme
        > model: DW1820A (BCM4350) 802.11ac Wireless
        > name: Airport
```

<p align="center">
    <img src="./dw1820a_inject.png">
</p>

    + Add kext to clover:
        + AirportBrcmFixup.kext
        + BrcmBluetoothInjector.kext
        + BrcmFirmwareData.kext
        + BrcmPatchRAM3.kext
        + BT4LEContinuityFixup.kext (Handoff fix? maybe)

```rb
    brcmfx-driver=1 brcmfx-country=#a #(wifi fix)
    bpr_probedelay=100 bpr_initialdelay=300 bpr_postresetdelay=300 #(blue fix after sleep)
```

<p>
    <img style="border-radius: 8px" src="./dw1820a.png">
</p>

    <> Other support card like DW1560 and DW1830 you can google and test it, much easy than DW1820A

## Using usb wifi

    + Suggest Comfast cf-811ac
    + Using https://github.com/chris1111/USB-Wireless-Utility to make it run in mojave and catalina

# X. Undervolt script

    +Too f**king hot?
    > Go here: https://github.com/tctien342/smart-cpu

# Thanks

    + @bavariancake [https://github.com/bavariancake/XPS9570-macOS]
    + @sicreative [https://github.com/sicreative/VoltageShift]
    + @hackintosh-stuff [https://github.com/hackintosh-stuff/ComboJack]
    + @LuletterSoul [https://github.com/LuletterSoul/Dell-XPS-15-9570-macOS-Mojave]
    + @chris1111 [https://github.com/chris1111/USB-Wireless-Utility]
