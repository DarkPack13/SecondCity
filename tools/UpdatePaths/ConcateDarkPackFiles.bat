@echo off
REM Run this one before you run the normal one so our update paths run first
type nul > darkpackmerged.txt
FOR /R .\Scripts\DarkPack %%f IN (*) DO (type "%%f" >> darkpackmerged.txt) && (echo. >> darkpackmerged.txt)
