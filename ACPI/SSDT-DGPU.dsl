/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of iASLPaFs1J.aml, Wed Mar 11 14:19:04 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000105 (261)
 *     Revision         0x02
 *     Checksum         0x34
 *     OEM ID           "hack"
 *     OEM Table ID     "DGPU"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
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

