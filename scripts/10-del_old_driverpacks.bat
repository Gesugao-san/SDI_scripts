
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET "VERBOSE_OUTPUT=true"
SET SDIPath=%~dp0
CLS

IF %VERBOSE_OUTPUT% == true (
    ECHO.
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO. * Snappy Driver Installer                           *
    ECHO. *   Driver Pack Cleanup                             *
    ECHO. *                                                   *
    ECHO. * Removes old versions of diverpacks, keeping the   *
    ECHO. *    most recent ones.                              *
    ECHO. *                                                   *
    ECHO. *                                                   *
    ECHO. *                                                   *
    ECHO. * By Computer Bloke                                 *
    ECHO. *   Modded by Gesugao-san                           *
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO.
)

ECHO Verbose output: %VERBOSE_OUTPUT%
TITLE=SDI Driver Pack Cleanup
CD /D "%SDIPath%"

@CD /D "%~dp0/drivers"
ATTRIB *.* -R
FOR /F "tokens=1,2,3,4,5,6,7 delims=_. usebackq" %%i IN (`DIR "*.7z" /B`) DO CALL :cleanup %%i %%j %%k %%l %%m %%n %%o
CD ..
GOTO :end

:cleanup
IF /I "%7" == "7z" CALL :clean %1_%2_%3_%4_%5 %6 && GOTO :eof
IF /I "%6" == "7z" CALL :clean %1_%2_%3_%4 %5 && GOTO :eof
IF /I "%5" == "7z" CALL :clean %1_%2_%3 %4 && GOTO :eof
IF /I "%4" == "7z" CALL :clean %1_%2 %3 && GOTO :eof
IF /I "%3" == "7z" CALL :clean %1 %2 && GOTO :eof
GOTO :eof

:clean
FOR /F "tokens=* usebackq" %%f IN (`DIR "%1_*.7z" /B /O:N`) DO SET "GOODFILE=%%f"
IF %VERBOSE_OUTPUT% == true ECHO Keeping most recent driver file: "%GOODFILE%"
FOR %%f IN (%1_*.7z) DO IF NOT "%%f" == "%GOODFILE%" (
    IF %VERBOSE_OUTPUT% == true (
        @REM Keeping most recent driver file: "%GOODFILE%"
        ECHO        Removing old driver file: "%%f"
    ) ELSE (
        ECHO "%%f"
    )
    DEL "%%f"
)
GOTO :eof

:end
IF %VERBOSE_OUTPUT% == true TIMEOUT 10
ENDLOCAL
EXIT /B %ERRORLEVEL%
