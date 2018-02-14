REM ***DOS script to get barcodes from images***
REM Fernley Symons 31-1-2018
REM Use: Put this file and the "decode_barcodes.exe" program in the folder with the image files
REM The script goes through all the image files (extensions PNG, JPG, JPEG and GIF) and runs Lawrence Hudson's decode_barcodes program against each. The output is piped to an output text file (outfile.txt). The script adds to this if it exists, and creates it if it doesn't. It works on all file in the folder and its subfolders.
REM When it's finished, you can import the output into XL.
REM decode_barcodes has various other options. In particular, it can rename the image file to the barcode. This is probably _not_ a good idea because sometimes an image has more than one barcode. Better to check the output and then create a DOS "rename" batch file.
REM See the Gouda repository for other options: https://github.com/NaturalHistoryMuseum/gouda
REM With luck this BAT is robust to spaces in file and directory names, and can be run from a shared area folder. But shout if you have problems
REM FS 14-2-2018: changed to: Add column headings, remove the "[]" which surrounded the barcodes and insert a tab delineator between the columns [i.e. change to tab-separated values format]
@echo off
setlocal enableDelayedExpansion
IF EXIST "%~dp0outfile.txt" del /F "%~dp0outfile.txt"
cd %~dp0
echo input filename	barcode(s) >> outfile1.txt
echo processing images...
@echo off
for /f "delims=" %%a IN ('dir /b /s *.png *.jpg *.jpeg *.gif') do decode_barcodes.exe --action terse libdmtx "%%a" >> outfile1.txt
for /F "tokens=*" %%A in (%~dp0outfile1.txt) do set str=%%A & set str1=!str:]=! & set str2=!str1: [=	! & echo !str2! >>outfile.txt
IF EXIST "%~dp0outfile1.txt" del /F "%~dp0outfile1.txt"