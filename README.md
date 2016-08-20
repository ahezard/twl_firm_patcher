# twl_firm_patcher

This patcher that allows to produce a special twlBg.cxi by patching the devLauncher SRL contained into it.

This modifed twlBg.cxi allows to unlock the TWL mode Hardware (DSI) into the NTR mode (DS)

This unlock new capability in NTR mode without breaking games:
-  boost arm9 speed (from 66 mhz to 133 mhz) : bit 1 of register 0x4004004 in ARM9 
-  SD access                                 : bit 1 of register 0x4004004 in ARM7 +  bit ? of register 0x4004008 (value 0x830F0100 works)
-  extended WRAM                             : bit 7 of register 0x4004004 in ARM7/ARM9 + bit 24 of register 0x4004008 in ARM9/ARM7
-  slot 1 reset                              : bit 2/3 of register 0x4004010 ( Follow the sequence desribe here http://problemkaputt.de/gbatek.htm#dsicontrolregistersscfg )  

The following capability do break games:
-  16 MB RAM                                 : bit 14 of register 0x4004008 in ARM9/ARM7, break the usual non cacheable mirror of the main memory 

Usage :
- Dump the twl_firm of your console using decrypt9 (SysNAND Options->Miscellanous->NCCH FIRMs Dump)
- rename it to firmware_twl.bin and put it into input.
- run go.cmd
- put the twlBg.cxi file into luma/sysmodules (V6.0 dev version required)
- an "enabler" program is needed to unlock the HW. 

Here are some example of enabler programs : 
- https://github.com/ahezard/ntr_extended__poc
- https://github.com/ahezard/woodrpg_forwarder
- https://github.com/ahezard/wood3ds
- https://github.com/ApacheThunder/NTR_Launcher

Here are the details of the patches implemented :

The idea is to replace all STR operations on the register 0x4004008 by STRH (only affect bit 1-16 leaving bit 16-32 untouched)

In devLauncher SRL :

ARM9 section (0x004000-0x02A000)
- offset 0x07368 replace 08 60 87 05 by B8 60 C7 01 (ARM7 SCFG unlock)

ARM7 section (0x02A000-0x034888)

ARM9i section (0x055C00-0x059C00)

ARM7i section (0x059C00-0x0B9150)
- offset 0xA5888 replace 02 01 1A E3 08 60 87 05 by 08 62 86 E3 08 60 87 E5 (ARM7 SCFG unlock)

All of this started from a Normatt theory so special thanks to him for the idea behind :
- [9:26:23 PM] Normmatt: 4004008h - DSi9 - SCFG_EXT - Extended Features (R/W) [8307F100h]
- [9:26:32 PM] Normmatt: just make sure bit31 is NEVER set
- [9:26:42 PM] Normmatt: and boom you can re-enable all twl hardware from ntr mode

Thanks again to Normatt for the ARM7 patch.

Thanks as well to Apache Thunder and Shutterbug2000 for the testing and hacking support.

Thanks to Nocash and Steveice10 for their reverse engineering work and the documentation produced.
 