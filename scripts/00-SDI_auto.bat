
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS

@REM 32-bit version of SDI works BOTH on 32-bit and 64-bit Windows.
@REM 64-bit version of SDI works ONLY on 64-bit Windows.
@REM EXECEPTION: 32-bit version of SDI cannot run on Windows PE x64.
@REM 64-bit version is faster and doesn't have the 2GB RAM per process limitation.

ECHO.
ECHO. *****************************************************
ECHO. * Snappy Driver Installer                           *
ECHO. *   Starter with autodetecting architecture         *
ECHO. *                                                   *
ECHO. * Original by https://sdi-tool.org/download/        *
ECHO. *   Modded by Gesugao-san                           *
ECHO. *****************************************************
ECHO.

TITLE=SDI starter (autodetecting architecture)

SET SDIPath=%~dp0
CD /d "%SDIPath%"

ECHO Detecting OS architecture...
IF %PROCESSOR_ARCHITECTURE% == x86 IF NOT DEFINED PROCESSOR_ARCHITEW6432 (
    GOTO architecture_32bit
) ELSE (
    GOTO architecture_64bit
)

:architecture_32bit
ECHO. Detected: 32-bit
SET xOS=R
GOTO search_file

:architecture_64bit
ECHO. Detected: 64-bit
SET xOS=x64_R
GOTO search_file

:search_file
ECHO Searching for: "SDI_%xOS%*.exe"
FOR /f "tokens=*" %%a IN ('DIR /b /od "%SDIPath%SDI_%xOS%*.exe"') DO SET "SDIEXE=%%a"
IF EXIST "%SDIEXE%" (
    @REM GLORIOUS
    ECHO. SUCCESS! Target executable file found.
    GOTO execute_file
) ELSE (
    ECHO.
    ECHO. FATAL ERROR! Target executable file not found!
    GOTO exit
)

:execute_file
ECHO Starting SDI...
START "Snappy Driver Installer" /d "%SDIPath%" "%SDIPath%%SDIEXE%" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO exit

:exit
TIMEOUT 5
EXIT /B %ERRORLEVEL%
