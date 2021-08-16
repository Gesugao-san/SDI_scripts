
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS
SET "VERBOSE_OUTPUT=true"
SET SDIPath=%~dp0
CLS

IF %VERBOSE_OUTPUT% == true (
    ECHO.
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO. * Snappy Driver Installer                           *
    ECHO. *   Logs Cleanup                                    *
    ECHO. *                                                   *
    ECHO. * Removes old versions and equals dublicates of     *
    ECHO. *   logs, keeping the most recent ones.             *
    ECHO. *                                                   *
    ECHO. *                                                   *
    ECHO. *                                                   *
    ECHO. * Original by JosefZ                                *
    ECHO. *   Modded by Gesugao-san                           *
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO.
)

ECHO Verbose output: %VERBOSE_OUTPUT%
TITLE=SDI Logs Cleanup
CD /D "%SDIPath%"

PUSHD "%~dp0logs"

IF %VERBOSE_OUTPUT% == true ECHO Searching: "logs\*.*""
FOR /F "delims=" %%G IN ('DIR "%SDIPath%logs\*.*" /B /A:-D') DO (
    CALL :proFC "%%~fG" "%~dp0logs\%%~nxG"
)
POPD
ENDLOCAL
GOTO :end

:raiseerror
EXIT /B %1

:proFC
CALL :raiseerror 321
FC /B "%~1" "%~2" >NUL 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO Del: "%~1"
    ECHO. Du: "%~2"
    @REM DEL "%~1"
) ELSE (
    ECHO %ERRORLEVEL% "%~2"
)
GOTO :eof

:end
TIMEOUT 10
EXIT /B %ERRORLEVEL%
