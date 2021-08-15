
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS
SET "VERBOSE_OUTPUT=true"
SET SDIPath=%~dp0

ECHO.
ECHO. *****************************************************
ECHO. * Snappy Driver Installer                           *
ECHO. *   Starter with autodetecting architecture         *
ECHO. *                                                   *
ECHO. *                                                   *
ECHO. *                                                   *
ECHO. *                                                   *
ECHO. *                                                   *
ECHO. *                                                   *
ECHO. * Original by https://sdi-tool.org/download/        *
ECHO. *   Modded by Gesugao-san                           *
ECHO. *****************************************************
ECHO.


@REM 32-bit version of SDI works BOTH on 32-bit and 64-bit Windows.
@REM 64-bit version of SDI works ONLY on 64-bit Windows.
@REM EXECEPTION: 32-bit version of SDI cannot run on Windows PE x64.
@REM 64-bit version is faster and doesn't have the 2GB RAM per process limitation.

ECHO Verbose output: %VERBOSE_OUTPUT%
TITLE=SDI starter (autodetecting architecture)
CD /d "%SDIPath%"

ECHO Detecting OS architecture...
IF %PROCESSOR_ARCHITECTURE% == x86 IF NOT DEFINED PROCESSOR_ARCHITEW6432 (
    GOTO architecture_32bit
) ELSE (
    GOTO architecture_64bit
)

:architecture_32bit
IF %VERBOSE_OUTPUT% == true (
    ECHO. Detected: 32-bit
) ELSE (
    ECHO. 32-bit
)
SET xOS=R
GOTO file_search

:architecture_64bit
IF %VERBOSE_OUTPUT% == true (
    ECHO. Detected: 64-bit
) ELSE (
    ECHO. 64-bit
)
SET xOS=x64_R
GOTO file_search

:file_search
IF %VERBOSE_OUTPUT% == true ECHO Searching for: "SDI_%xOS%*.exe"
FOR /f "tokens=*" %%a IN ('DIR "%SDIPath%SDI_%xOS%*.exe" /B /O:D') DO SET "SDIEXE=%%a"
IF EXIST "%SDIEXE%" (
    IF %VERBOSE_OUTPUT% == true (
        @REM GLORIOUS
        ECHO. SUCCESS! Target executable file found.
    )
    GOTO file_execute
) ELSE (
    IF %VERBOSE_OUTPUT% == true (
        ECHO.
        ECHO. FATAL ERROR! Target executable file not found!
    ) ELSE (
        Error: target executable file not found, exiting.
    )
    GOTO exit
)

:file_execute
IF %VERBOSE_OUTPUT% == true ECHO Starting SDI...
START "Snappy Driver Installer" /D "%SDIPath%" "%SDIPath%%SDIEXE%" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO exit

:exit
IF %VERBOSE_OUTPUT% == true TIMEOUT 10
EXIT /B %ERRORLEVEL%
