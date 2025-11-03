@echo off
REM Loop through all dropped files
for %%F in (%*) do (
    call "%~dp0\..\bootstrap\python" -m UpdatePaths "%%~F" --directory "../../_maps/map_files/Vampire"
)
pause
