/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of iASLy7PQrN.aml, Wed Mar 11 14:19:31 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000111 (273)
 *     Revision         0x02
 *     Checksum         0xE7
 *     OEM ID           "ACDT"
 *     OEM Table ID     "EXT4"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180427 (538444839)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "EXT4", 0x00000000)
{
    External (_SB_.LID0, DeviceObj)    // (from opcode)
    External (_SB_.LID_, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.LID0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.LID_, DeviceObj)    // (from opcode)

    Method (EXT4, 1, NotSerialized)
    {
        If (LEqual (0x03, Arg0))
        {
            If (CondRefOf (\_SB.LID))
            {
                Notify (\_SB.LID, 0x80)
            }

            If (CondRefOf (\_SB.LID0))
            {
                Notify (\_SB.LID0, 0x80)
            }

            If (CondRefOf (\_SB.PCI0.LPCB.LID))
            {
                Notify (\_SB.PCI0.LPCB.LID, 0x80)
            }

            If (CondRefOf (\_SB.PCI0.LPCB.LID0))
            {
                Notify (\_SB.PCI0.LPCB.LID0, 0x80)
            }
        }
    }
}

