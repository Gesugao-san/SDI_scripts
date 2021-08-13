
@ECHO OFF
REM 32-bit version of SDI works BOTH on 32-bit and 64-bit Windows.
REM 64-bit version of SDI works ONLY on 64-bit Windows.
REM EXECEPTION: 32-bit version of SDI cannot run on Windows PE x64.
REM 64-bit version is faster and doesn't have the 2GB RAM per process limitation.

TITLE=Snappy Driver Installer starter (autodetecting architecture)

IF %PROCESSOR_ARCHITECTURE% == x86 (
    IF NOT DEFINED PROCESSOR_ARCHITEW6432 GOTO bit32
)
GOTO bit64

:bit32
ECHO 32-bit
SET xOS="R"
GOTO cont

:bit64
ECHO 64-bit
SET xOS="x64_R"

:cont
FOR /f "tokens=*" %%a in ('dir /b /od "%~dp0SDI_%xOS%*.exe"') do SET "SDIEXE=%%a"
IF EXIST "%~dp0%SDIEXE%" (
 START "Snappy Driver Installer" /d"%~dp0" "%~dp0%SDIEXE%" %1 %2 %3 %4 %5 %6 %7 %8 %9
 GOTO ex
) ELSE (
 ECHO.
 ECHO  Not found 'Snappy Driver Installer'!
 ECHO.
 TIMEOUT 6
)
:ex
