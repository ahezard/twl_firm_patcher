@@Echo off
cd ../temp
..\tools\ctrtool.exe -xt firm --firmdir firm firmware_twl.bin 
cp firm/firm_0_18000000.bin twlBg_original.cxi

pause

..\tools\3dstool.exe -xvtf cxi twlBg_original.cxi --header twlBg.ncch.header --exh twlBg.exheader.bin --exefs twlBg.exefs

..\tools\3dstool.exe -xuvtf exefs twlBg.exefs --header twlBg.exefs.header --exefs-dir twlBg_original_exefs

python ..\scripts\extract_dev_launcher_srl_from_twlbg_cxi.py --cxi twlBg_original_exefs/code.bin --out devSRLlauncher_original_enc.nds

..\tools\twltool.exe modcrypt --in devSRLlauncher_original_enc.nds --out devSRLlauncher_original_dec.nds

..\tools\ndstool.exe -i devSRLlauncher_original_dec.nds > devSRLlauncher_original_header.txt

..\tools\ndstool.exe -x -9 devSRLlauncher_original_dec.arm9 -7 devSRLlauncher_original_dec.arm7 devSRLlauncher_original_dec.nds

python ..\scripts\patchDevLauncher.py --srl devSRLlauncher_original_dec.nds --out devSRLlauncher_patched_dec.nds

cd ..\scripts
pause
