@@Echo off
python build_firm_bin_from_twlbg_cxi.py --cxi loader/twlBg_patched.cxi --firm ExeFS/code.bin --out patched_firmware_twl.bin

ctrtool.exe -it firm patched_firmware_twl.bin
pause
