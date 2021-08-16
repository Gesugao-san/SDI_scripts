
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS
SET "VERBOSE_OUTPUT=true"
SET SDIPath=%~dp0
CLS

IF %VERBOSE_OUTPUT% == true (
    ECHO.
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO. * Snappy Driver Installer                           *
    ECHO. *   All driverpacks unpacker                        *
    ECHO. *                                                   *
    ECHO. * Script for unpacking all driverpacks              *
    ECHO. *   ^(requires ~90GB^)                              *
    ECHO. *                                                   *
    ECHO. *                                                   *
    ECHO. *                                                   *
    ECHO. * Original by https://sdi-tool.org/settings/        *
    ECHO. *   Modded by Gesugao-san                           *
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO.
)

ECHO Verbose output: %VERBOSE_OUTPUT%
TITLE=SDI All driverpacks unpacker
CD /D "%SDIPath%"

@REM Get the newest SDI_Rnnn.exe file
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO Searching for: "SDI_R*.exe"
FOR /F "tokens=*" %%a IN ('DIR "%SDIPath%SDI_R*.exe" /B /O:D /A:-D') DO SET "SDIEXE=%%a"
IF EXIST "%SDIEXE%" (
    ECHO. OK
) ELSE (
    IF %VERBOSE_OUTPUT% == true (
        ECHO.
        ECHO. FATAL ERROR! Target executable file not found!
    ) ELSE (
        ECHO. Error: target executable file not found, exiting.
    )
    GOTO end
)

FOR /F %%i IN ('DIR "%SDIPath%drivers\*.7z" /B /O:D /A:-D') DO %SDIEXE% -7z x "drivers\%%i" -y -odrivers\%%~ni
DEL ".\indexes\SDI\unpacked.bin"
ECHO -keepunpackedindex >> sdi.cfg

:end
IF %VERBOSE_OUTPUT% == true TIMEOUT 10
EXIT /B %ERRORLEVEL%
