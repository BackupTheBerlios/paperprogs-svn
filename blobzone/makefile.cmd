@echo off
cd bin
del images_sdk_bin_current.zip
del bin_current.zip
del src_bin_current.zip
cd ..\images_sdk
del/ah /f *.db
7z a -r -tzip -mx0 images_sdk_bin_current.zip *
copy images_sdk_bin_current.zip ..\bin
del images_sdk_bin_current.zip
cd ..\src
del/ah /f *.db
7z a -r -tzip -mx0 bin_current.zip @bin.txt
copy bin_current.zip ..\bin
del bin_current.zip
7z a -r -tzip -mx0 src_bin_current.zip @src.txt
copy src_bin_current.zip ..\bin
del src_bin_current.zip
cd..