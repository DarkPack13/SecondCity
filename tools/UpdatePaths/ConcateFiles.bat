@echo off
type nul > merged.txt
FOR /R .\Scripts %%f IN (*) DO (type "%%f" >> merged.txt) && (echo. >> merged.txt)
