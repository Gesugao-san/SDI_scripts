
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS

ECHO.
ECHO. *****************************************************
ECHO. * Snappy Driver Installer                           *
ECHO. *   All driverpacks unpacker                        *
ECHO. *                                                   *
ECHO. * Script for unpacking all driverpacks              *
ECHO. *   (requires about 90GB).                          *
ECHO. *                                                   *
ECHO. * Original by https://sdi-tool.org/settings/        *
ECHO. *   Modded by Gesugao-san                           *
ECHO. *****************************************************
ECHO.

@REM Get the newest SDI_Rnnn.exe file
FOR /f "tokens=*" %%a IN ('DIR /b /od "%~dp0SDI_R*.exe"') DO SET "SDIEXE=%%a"

FOR /F %%i IN ('DIR /b "drivers\*.7z"') DO %SDIEXE% -7z x "drivers\%%i" -y -odrivers\%%~ni
DEL ".\indexes\SDI\unpacked.bin"
ECHO -keepunpackedindex >> sdi.cfg

TIMEOUT 5
EXIT /B %ERRORLEVEL%
