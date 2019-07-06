@@Echo off
cd ../temp
..\tools\ctrtool.exe -xt firm --firmdir firm firmware_twl.bin 
cp firm/firm_0_18000000.bin twlBg_original.cxi
cp firm/firm_3_08006000.bin process9_original.cxi

pause

..\tools\3dstool.exe -xvtf cxi twlBg_original.cxi --header twlBg.ncch.header --exh twlBg.exheader.bin --exefs twlBg.exefs

..\tools\3dstool.exe -xvtf cxi process9_original.cxi --header process9.ncch.header --exh process9.exheader.bin --exefs process9.exefs

..\tools\3dstool.exe -xuvtf exefs twlBg.exefs --header twlBg.exefs.header --exefs-dir twlBg_original_exefs

..\tools\3dstool.exe -xuvtf exefs process9.exefs--header process9.exefs.header --exefs-dir process9_original_exefs

mkdir twlBg_patched_exefs 

python ..\scripts\patch_twl_bg.py --srl=twlBg_original_exefs\code.bin --out=twlBg_patched_exefs\code.bin   

..\tools\3dstool.exe -czvtf exefs twlBg_patched.exefs --header twlBg.exefs.header --exefs-dir twlBg_patched_exefs

..\tools\3dstool.exe -cvtf cxi ..\TwlBg.cxi --header twlBg.ncch.header --exh twlBg.exheader.bin --exefs twlBg_patched.exefs

cd ..\scripts
pause
