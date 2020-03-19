// Disable discrete GPU
// Patch: Rename _WAK to ZWAK
// Find: FDlfV0FLAQ==
// Replace: FDlaV0FLAQ==
// Reference:
// [1] https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-DDGPU.dsl
// [2] https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-PTSWAK.dsl
DefinitionBlock ("", "SSDT", 2, "hack", "DGPU", 0x00000000)
{
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)    // 0 Arguments (from opcode)
    External (EXT4, MethodObj)    // 1 Arguments (from opcode)
    External (ZWAK, MethodObj)    // 1 Arguments (from opcode)

    Method (DGPU, 0, NotSerialized)
    {
        If (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF))
        {
            \_SB.PCI0.PEG0.PEGP._OFF ()
        }
    }

    Device (RMD1)
    {
        Name (_HID, "RMD10000")  // _HID: Hardware ID
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                DGPU ()
            }
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }

            Return (Zero)
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        Store (ZWAK (Arg0), Local0)
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (EXT4))
            {
                EXT4 (Arg0)
            }

            DGPU ()
        }

        Return (Local0)
    }
}

