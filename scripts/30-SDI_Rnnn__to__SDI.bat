
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS
SET "VERBOSE_OUTPUT=true"
CLS


IF %VERBOSE_OUTPUT% == true (
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
)

ECHO Verbose output: %VERBOSE_OUTPUT%
TITLE=SDI Updater SDI.exe


::SET SDIPath to location of batch file which should be with SDI_Rnnn.exe
SET SDIPath=%~dp0

PUSHD %SDIPath%

::Get the newest SDI_Rnnn.exe file
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO Searching for: "SDI_R*.exe"
FOR /F "delims=|" %%I IN ('DIR "%SDIPath%SDI_R*.exe" /B /O:D /A:-D') DO SET NewestSDI=%%I
IF EXIST "%NewestSDI%" (
    ECHO. OK
) ELSE (
    IF %VERBOSE_OUTPUT% == true (
        ECHO.
        ECHO. FATAL ERROR! Target executable file not found!
    ) ELSE (
        Error: target executable file not found, exiting.
    )
    GOTO end
)
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO.

:: Run SDI update
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO Run SDI update
CALL %NewestSDI% /autoupdate /autoclose
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO.

::Make sure we still have most current executable in case one was just downloaded
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO Searching for most current: "SDI_R*.exe"
FOR /F "delims=|" %%I IN ('DIR "%SDIPath%SDI_R*.exe" /B /O:D /A:-D') DO SET NewestSDI=%%I
IF EXIST "%NewestSDI%" (
    ECHO. OK
) ELSE (
    IF %VERBOSE_OUTPUT% == true (
        ECHO.
        ECHO. FATAL ERROR! Target executable file not found!
    ) ELSE (
        Error: target executable file not found, exiting.
    )
    GOTO end
)
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO.

::Copy current version to SDI.exe
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO Copy current version to SDI.exe
COPY %NewestSDI% SDI.exe /Y
IF %VERBOSE_OUTPUT% == true ECHO. *** & ECHO.

POPD

:end
IF %VERBOSE_OUTPUT% == true TIMEOUT 10
EXIT /B %ERRORLEVEL%
