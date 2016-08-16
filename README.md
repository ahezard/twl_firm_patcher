# twl_firm_patcher

This patcher that allows to produce a special twlBg.cxi by patching the devLauncher SRL contained into it.

This modifed twlBg.cxi allows to unlock part of the TWL mode Hardware (DSI) into the NTR mode (DS)

The main advantage available is the capability to boost arm9 speed (from 66 mhz to 133 mhz) without breaking NTR games.

Usage :
- put firmware_twl.bin (O3DS or N3DS) into input
- run go.cmd
- put the twlBg.cxi file into luma/sysmodules (V6.0 dev version required)
- an "enabler" program is needed to unlock the HW. Here is an example : https://github.com/ahezard/ntr_extended__poc

Here is the details of the patch implemented :

The idea is to replace all STR operation on the register 0x4004008 by STRH (only affect bit 1-16 leaving bit 16-32 untouched)

In devLauncher SRL :

ARM9 section
- offset 0x07368 replace 08 60 87 05 by B8 60 C7 01
- offset 0x2A180 replace 00 00 81 E5 by B0 00 C1 E1

ARM7 section
- offset 0xA61EC replace 00 00 85 E5 by B0 00 C5 E1
- offset 0xA6244 replace 00 00 82 E5 by B0 00 C2 E1
- offset 0xA6250 replace 00 00 82 15 by B0 00 C2 11
- offset 0xA6278 replace 04 00 82 E5 by B4 00 C2 E1
- offset 0xA6298 replace 00 10 82 E5 by B0 10 C2 E1

All of this started from a Normatt theory so special thanks to him for the idea behind :
- [9:26:23 PM] Normmatt: 4004008h - DSi9 - SCFG_EXT - Extended Features (R/W) [8307F100h]
- [9:26:32 PM] Normmatt: just make sure bit31 is NEVER set
- [9:26:42 PM] Normmatt: and boom you can re-enable all twl hardware from ntr mode

Thanks as well to Apache Thunder and Shutterbug2000 for the testing and hacking support.
 