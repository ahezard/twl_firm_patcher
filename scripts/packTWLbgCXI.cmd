mkdir loader\twlBg_patched_exefs 

python build_twlbg_code_from_dev_launcher_srl.py --srl=loader/devSRLlauncher_patched_enc.nds --code=loader/twlBg_original_exefs/code.bin --out=loader/twlBg_patched_exefs/code.bin 

3dstool -czvtf exefs loader/twlBg_patched.exefs --header loader/twlBg.exefs.header --exefs-dir loader/twlBg_patched_exefs

3dstool -cvtf cxi loader/twlBg_patched.cxi --header loader/twlBg.ncch.header --exh loader/twlBg.exheader.bin --exefs loader/twlBg_patched.exefs 

pause