@@Echo off
cd ../temp
..\tools\ctrtool.exe -xt firm --firmdir firm firmware_twl.bin 
cp firm/firm_0_18000000.bin twlBg_original.cxi

pause

..\tools\3dstool.exe -xvtf cxi twlBg_original.cxi --header twlBg.ncch.header --exh twlBg.exheader.bin --exefs twlBg.exefs

..\tools\3dstool.exe -xuvtf exefs twlBg.exefs --header twlBg.exefs.header --exefs-dir twlBg_original_exefs

python ..\scripts\extract_dev_launcher_srl_from_twlbg_cxi_n3ds.py --cxi twlBg_original_exefs/code.bin --out devSRLlauncher_original_enc.nds

..\tools\twltool.exe modcrypt --in devSRLlauncher_original_enc.nds --out devSRLlauncher_original_dec.nds

..\tools\ndstool.exe -i devSRLlauncher_original_dec.nds > devSRLlauncher_original_header.txt

..\tools\ndstool.exe -x -9 devSRLlauncher_original_dec.arm9 -7 devSRLlauncher_original_dec.arm7 devSRLlauncher_original_dec.nds

python ..\scripts\patchDevLauncher.py --srl devSRLlauncher_original_dec.nds --out devSRLlauncher_patched_dec.nds

copy devSRLlauncher_patched_dec.nds devSRLlauncher_patched_enc.nds
..\tools\TWLTool.exe modcrypt --in %1 devSRLlauncher_patched_enc.nds

mkdir twlBg_patched_exefs 

python ..\scripts\build_twlbg_code_from_dev_launcher_srl_n3ds.py --srl=devSRLlauncher_patched_enc.nds --code=twlBg_original_exefs\code.bin --out=code.bin

python ..\scripts\patch_twl_bg.py --srl=code.bin --out=twlBg_patched_exefs\code.bin  

..\tools\3dstool.exe -czvtf exefs twlBg_patched.exefs --header twlBg.exefs.header --exefs-dir twlBg_patched_exefs

..\tools\3dstool.exe -cvtf cxi ..\TwlBg.cxi --header twlBg.ncch.header --exh twlBg.exheader.bin --exefs twlBg_patched.exefs

cd ..\scripts
pause
