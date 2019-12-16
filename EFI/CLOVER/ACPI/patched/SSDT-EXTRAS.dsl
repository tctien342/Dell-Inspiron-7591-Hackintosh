// More hack
DefinitionBlock ("", "SSDT", 2, "hack", "INS759X", 0x00000000)
{
    External (_SB_.AMW0, DeviceObj)
    External (_SB_.AMW1, DeviceObj)
    External (_SB_.AMW2, DeviceObj)
    External (_SB_.AMW4, DeviceObj)
    If (_OSI ("Darwin"))
    {
//        Scope (_SB)
//        {
//            Scope (AMW0)
//            {
//                Name (_STA, Zero)  // _STA: Status
//            }
//            Scope (AMW1)
//            {
//                Name (_STA, Zero)  // _STA: Status
//            }
//            Scope (AMW2)
//            {
//                Name (_STA, Zero)  // _STA: Status
//            }
//            Scope (AMW4)
//            {
//                Name (_STA, Zero)  // _STA: Status
//            }
//        }
        
        Method (PNOT, 0, Serialized)
        {
        
            // do nothing

        }
    }
}