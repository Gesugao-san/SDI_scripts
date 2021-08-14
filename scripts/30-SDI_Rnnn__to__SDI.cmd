
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS

ECHO.
ECHO. *****************************************************
ECHO. * Snappy Driver Installer                           *
ECHO. *   Updater SDI.exe from last SDI_R***.exe          *
ECHO. *                                                   *
ECHO. * Keep SDI.exe updated with the latest drivers and  *
ECHO. *   version of SDI_Rnnn.exe                         *
ECHO. * NOTE: Put this batch file in the SDI_UPDATE       *
ECHO. *   directory with the SDI_Rnnn.exe file            *
ECHO. *                                                   *
ECHO. * Original by https://sdi-tool.org/settings/        *
ECHO. *   Modded by Gesugao-san                           *
ECHO. *****************************************************
ECHO.

::SET SDIPath to location of batch file which should be with SDI_Rnnn.exe
SET SDIPath=%~dp0

PUSHD %SDIPath%

::Get the newest SDI_Rnnn.exe file
FOR /F "delims=|" %%I IN ('DIR "SDI_R*.exe" /B /O:D') DO SET NewestSDI=%%I

:: Run SDI update
CALL %NewestSDI% /autoupdate /autoclose

::Make sure we still have most current executable in case one was just downloaded
FOR /F "delims=|" %%I IN ('DIR "SDI_R*.exe" /B /O:D') DO SET NewestSDI=%%I

::Copy current version to SDI.exe
COPY %NewestSDI% SDI.exe /Y

POPD

TIMEOUT 5
EXIT /B %ERRORLEVEL%
