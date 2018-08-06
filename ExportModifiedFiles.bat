echo off

set svn_url=%1
set rev_old=%2
set rev_new=%3
set export_path_old=%4
set export_path_new=%5

setlocal enabledelayedexpansion
for /f "tokens=1,2" %%i in ('svn diff -r %rev_old%:%rev_new% %svn_url%') do (
    set postfix=%%~xj
    
    if !postfix! == .xlsx (    
        if not exist %export_path_old% mkdir %export_path_old%
        if not exist %export_path_new% mkdir %export_path_new%

        set file_url=%svn_url%/%%j
        svn export --depth empty -q --force -r %rev_old% !file_url! %export_path_old%%%~nxj
        svn export --depth empty -q --force -r %rev_new% !file_url! %export_path_new%%%~nxj
        echo copyed : %%~nxj
        echo=
    )
)
endlocal

echo Export Completed!