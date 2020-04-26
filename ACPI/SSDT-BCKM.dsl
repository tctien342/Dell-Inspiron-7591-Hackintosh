// Make brightness control and brightness keys work
// Patch: Rename BRT6 to BRTX
// Find: QlJUNgI=
// Replace: QlJUWAI=
// References:
// [1] https://github.com/daliansky/OC-little/blob/master/05-OC-PNLF%E6%B3%A8%E5%85%A5%E6%96%B9%E6%B3%95/%E5%AE%9A%E5%88%B6%E4%BA%AE%E5%BA%A6%E8%A1%A5%E4%B8%81/SSDT-PNLF-CFL.dsl
// [2] https://github.com/daliansky/OC-little/tree/master/%E4%BF%9D%E7%95%99%E9%A1%B9%E7%9B%AE/X02-%E4%BA%AE%E5%BA%A6%E5%BF%AB%E6%8D%B7%E9%94%AE%E8%A1%A5%E4%B8%81
// [3] https://www.dell.com/community/Precision-Mobile-Workstations/Fn-and-brightness-key-causing-a-lot-of-errors-in-kernel-logs/td-p/7393145

DefinitionBlock ("", "SSDT", 2, "hack", "BCKM", 0x00000000)
{
    External (_SB_.ACOS, IntObj)
    External (_SB_.ACSE, IntObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.GFX0.BRTX, MethodObj)
    External (_SB_.PCI0.GFX0.LCD_, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.LCD_, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.EVD5, FieldUnitObj)
    
    // inject PNLF for CoffeeLake to make brightness control work[1]
    Scope (_SB)
    {
        Device (PNLF)
        {
            Name(_ADR, Zero)
        Name(_HID, EisaId("APP0002"))
        Name(_CID, "backlight")
        // _UID is set depending on PWMMax to match profiles in AppleBacklightFixup.kext Info.plist
        // 14: Sandy/Ivy 0x710
        // 15: Haswell/Broadwell 0xad9
        // 16: Skylake/KabyLake 0x56c (and some Haswell, example 0xa2e0008)
        // 17: custom LMAX=0x7a1
        // 18: custom LMAX=0x1499
        // 19: CoffeeLake 0xffff
        // 99: Other (requires custom AppleBacklightInjector.kext/AppleBackightFixup.kext)
        Name(_UID, 19)
        Name(_STA, 0x0B)
        }
    }
    
    // make BRT6 to be called on Darwin
    // call chain: _Q66 -> NEVT -> SMIE -> SMEE -> EV5 -> BRT6
    // in SMEE, EV5 is called only when OSID >= 0x20, and OSID:
    //     if ACOS == 0: init ACOS based on OS version
    //     return ACOS
    // hence set ACOS >= 0x20 can do the trick, and this trick affects less methods than _OSI renaming patch
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.ACOS = 0x80
            \_SB.ACSE = 0
            
        }
    }

    // notify PS2K when brightness control key was pressed[2]
    Scope (\_SB.PCI0.GFX0)
    {
        Method (BRT6, 2, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (Arg0, One))
            {
                Notify (^LCD, 0x86)    //native code
                Notify (^^LPCB.PS2K, 0x10)    //ELAN code
                Notify (^^LPCB.PS2K, 0x0206) // PS2 code
                Notify (^^LPCB.PS2K, 0x0286) // PS2 code
            }

            If (And (Arg0, 0x02))
            {
                Notify (^LCD, 0x87)    //native code
                Notify (^^LPCB.PS2K, 0x20)    //ELAN code
                Notify (^^LPCB.PS2K, 0x0205) // PS2 code
                Notify (^^LPCB.PS2K, 0x0285) // PS2 code
            }
            }
            Else
            {
                \_SB.PCI0.GFX0.BRTX (Arg0, Arg1)
            }
        }
    }

    Scope(_SB.PCI0.PEG0.PEGP)
    {
        Method (BRT6, 2, NotSerialized)
        {
            // try to fix[3]
            If (!_OSI ("Darwin") && (EVD5 == One) && CondRefOf(\_SB.PCI0.PEG0.PEGP.LCD))
            {
                If ((Arg0 == One))
                {
                    Notify (\_SB.PCI0.PEG0.PEGP.LCD, 0x86) // Device-Specific
                }

                If ((Arg0 & 0x02))
                {
                    Notify (\_SB.PCI0.PEG0.PEGP.LCD, 0x87) // Device-Specific
                }
            }
        }
    }
}

