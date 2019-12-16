// By LuletterSoul

// "GPIO Controller Enable" patch for ensuring your DSDT notifies the system that your device is GPIO pinned

// TPD1 is the ACPI id of tracpad 

// TPL1 is the ACPI id of touchscreen

// TPD1 and TPL1 are all I2C device in Dell XPS 9570 ,speacially TPD1

// Only enbale TPD1's GPIO interrupt mode



DefinitionBlock ("", "SSDT", 2, "hack", "I2C", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C1.TPD1, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C1.TPD1.SBFB, FieldUnitObj)    // (from opcode)
    
    Method (_SB.PCI0.GPI0._STA, 0, NotSerialized)  // _STA: Status
    {
        Return (0x0F)
    }


    Scope (_SB.PCI0.I2C1.TPD1)
    {            
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0023
                    }
            })
            Return (ConcatenateResTemplate (SBFB, SBFG))
        }
    }

}

