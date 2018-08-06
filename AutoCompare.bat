echo off

set rev_new=新版本号
set rev_old=旧版本号
set svn_url=svn地址

set cwd=%~dp0
set export_path_old=%cwd%folder_old\
set export_path_new=%cwd%folder_new\
set report_path=%cwd%report\
set zip_file_path=%cwd%report.zip
set zip_exe_path="C:\Program Files\2345Soft\HaoZip\HaoZipC.exe"

set start_time=%time%
echo ================= Start Delete Old Files =================
if exist %export_path_old% rd /s /q %export_path_old%
if exist %export_path_new% rd /s /q %export_path_new%
if exist %report_path% rd /s /q %report_path%
if exist %zip_file_path% del /q %zip_file_path%
echo ================= End Delete Old Files =================
echo=

echo export_path_old = %export_path_old%
echo export_path_new = %export_path_new%

echo ================= Start Export Two Version Files =================
call ExportModifiedFiles.bat %svn_url% %rev_old% %rev_new% %export_path_old% %export_path_new%
echo ================= End Export Two Version Files =================
echo=

echo ================= Start Compare Difference =================
echo=

cd %export_path_old%
setlocal enabledelayedexpansion
for /r %%i in (*) do (
    set name_noEx=%%~ni
    set name_withEx=%%~nxi    
    
    set report_file=%report_path%!name_noEx!.htm
    set file1_path=%%i
    set file2_path=%export_path_new%!name_withEx!
    set bcBatchTxt=@%cwd%BCBatch.txt

    echo old_file    = !file1_path!
    echo new_file    = !file2_path!
    echo report_file = !report_file!
   
    call .\..\CompareOperation.bat !report_file! !file1_path! !file2_path! !bcBatchTxt!    

    echo ==========================================
    echo ==========================================
    echo= 
)
endlocal
echo ================= End Compare Difference =================
echo=

echo ================= Start Generate Zip File =================
%zip_exe_path% a -tzip %zip_file_path% %report_path%*
echo ================= End Generate Zip File =================
echo=

echo Start Time = %start_time%
echo End Time   = %time%
echo=

echo All Completed!
pause