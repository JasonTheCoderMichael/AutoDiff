echo off

REM 参数1:生成的report文件 
REM 参数2:文件1 
REM 参数3:文件2
REM 参数4:BCBatch.txt文件

set exe_path="C:\Program Files\Beyond Compare 4\BComp.exe"
%exe_path% /silent /solo %4 %1 %2 %3