/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of iASLCNQPFZ.aml, Sat Mar 14 11:13:20 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000002CB (715)
 *     Revision         0x02
 *     Checksum         0x79
 *     OEM ID           "hack"
 *     OEM Table ID     "TYPC"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180427 (538444839)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "USB", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.XHC_, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.RP17, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.RP17.PXSX, DeviceObj)    // (from opcode)
    
    Method (_SB.PCI0.XHC._DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
    {
        If (LNot (Arg2))
        {
            Return (Buffer (One)
            {
                 0x03                                           
            })
        }

        Store (Package (0x0E)
            {
                "RM,pr2-force", 
                Buffer (0x04)
                {
                     0x00, 0x00, 0x00, 0x00                         
                }, 

                "subsystem-id", 
                Buffer (0x04)
                {
                     0x70, 0x72, 0x00, 0x00                         
                }, 

                "subsystem-vendor-id", 
                Buffer (0x04)
                {
                     0x86, 0x80, 0x00, 0x00                         
                }, 

                "AAPL,current-available", 
                Buffer (0x04)
                {
                     0x34, 0x08, 0x00, 0x00                         
                }, 

                "AAPL,current-extra", 
                Buffer (0x04)
                {
                     0x98, 0x08, 0x00, 0x00                         
                }, 

                "AAPL,current-extra-in-sleep", 
                Buffer (0x04)
                {
                     0x40, 0x06, 0x00, 0x00                         
                }, 

                "AAPL,max-port-current-in-sleep", 
                Buffer (0x04)
                {
                     0x34, 0x08, 0x00, 0x00                         
                }
            }, Local0)
        If (LOr (LOr (CondRefOf (\_SB.PCI0.RMD2), CondRefOf (\_SB.PCI0.RMD3)), CondRefOf (\_SB.PCI0.RMD4)))
        {
            CreateDWordField (DerefOf (Index (Local0, One)), Zero, PR2F)
            Store (0x3FFF, PR2F)
        }

        Return (Local0)
    }
    Scope (\_SB)
    {
	    Device (USBX)
	    {
	        Name (_ADR, Zero)  // _ADR: Address
	        Method (_STA, 0, NotSerialized)  // _STA: Status
	        {
	            If (_OSI ("Darwin")) 
                { Return (0x0F) }
                Return (Zero)
	        }

	        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
	        {
	            If (!Arg2)
	            {
	                Return (Buffer (One)
	                {
	                     0x03                                             // .
	                })
	            }

	            Return (Package (0x04)
	            {
	                "kUSBSleepPortCurrentLimit", 
	                0x0BB8, 
	                "kUSBWakePortCurrentLimit", 
	                0x0BB8
	            })
	        }
	    }
    }
    
    Scope (\_SB.PCI0.RP17)
    {
        Name (RTBT, One)
    }

    Scope (\_SB.PCI0.RP17.PXSX)
    {
        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (One)
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }

        Device (TBL3)
        {
            Name (_ADR, 0x00020000)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }

            Device (TBTU)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x6D, 
                    Zero
                })
                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (GPLD, 2, Serialized)
                    {
                        Name (PCKG, Package (0x01)
                        {
                            Buffer (0x10){}
                        })
                        CreateField (DerefOf (Index (PCKG, Zero)), Zero, 0x07, REV)
                        Store (One, REV)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x40, One, VISI)
                        Store (Arg0, VISI)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x57, 0x08, GPOS)
                        Store (Arg1, GPOS)
                        Return (PCKG)
                    }

                    Method (GUPC, 1, Serialized)
                    {
                        Name (PCKG, Package (0x04)
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Store (Arg0, Index (PCKG, Zero))
                        Return (PCKG)
                    }

                    Method (TPLD, 2, Serialized)
                    {
                        Name (PCKG, Package (0x01)
                        {
                            Buffer (0x10){}
                        })
                        CreateField (DerefOf (Index (PCKG, Zero)), Zero, 0x07, REV)
                        Store (One, REV)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x40, One, VISI)
                        Store (Arg0, VISI)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x57, 0x08, GPOS)
                        Store (Arg1, GPOS)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x4A, 0x04, SHAP)
                        Store (One, SHAP)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x20, 0x10, WID)
                        Store (0x08, WID)
                        CreateField (DerefOf (Index (PCKG, Zero)), 0x30, 0x10, HGT)
                        Store (0x03, HGT)
                        Return (PCKG)
                    }

                    Method (TUPC, 1, Serialized)
                    {
                        Name (PCKG, Package (0x04)
                        {
                            One, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        Store (Arg0, Index (PCKG, One))
                        Return (PCKG)
                    }

                    Device (UB21)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (TUPC (0x09))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (TPLD (One, One))
                        }
                    }

                    Device (UB22)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (Zero))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (GPLD (Zero, Zero))
                        }
                    }

                    Device (UB31)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (TUPC (0x09))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (TPLD (One, One))
                        }
                    }

                    Device (UB32)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (Zero))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (GPLD (Zero, Zero))
                        }
                    }
                }
            }
        }
    }
}

