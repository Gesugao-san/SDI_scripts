
@ECHO OFF >NUL
SETLOCAL ENABLEEXTENSIONS

ECHO.
ECHO. *****************************************************
ECHO. * Snappy Driver Installer                           *
ECHO. *   Logs Cleanup                                    *
ECHO. *                                                   *
ECHO. * Removes old versions and equals dublicates of     *
ECHO. *   logs, keeping the most recent ones.             *
ECHO. *                                                   *
ECHO. * By JosefZ                                         *
ECHO. *   Modded by Gesugao-san                           *
ECHO. *****************************************************
ECHO.

PUSHD "%~dp0logs"

for /F "delims=" %%G IN ('DIR /B /A:-D *.*') DO (
    CALL :proFC "%%~fG" "%~dp0logs\%%~nxG"
)
POPD
ENDLOCAL
GOTO :eof

:raiseerror
EXIT /B %1

:proFC
CALL :raiseerror 321
FC /B "%~1" "%~2" >NUL 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO Del: "%~1"
    ECHO. Du: "%~2"
) ELSE (
    ECHO %ERRORLEVEL% "%~2"
)
GOTO :eof
