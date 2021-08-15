
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS
SET "VERBOSE_OUTPUT=true"
SET SDIPath=%~dp0

ECHO.
ECHO. *****************************************************
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
ECHO. *****************************************************
ECHO.


ECHO Verbose output: %VERBOSE_OUTPUT%
TITLE=SDI Driver Pack Cleanup
CD /d "%SDIPath%"

@CD /d "%~dp0/drivers"
ATTRIB *.* -R
FOR /f "tokens=1,2,3,4,5,6,7 delims=_. usebackq" %%i IN (`DIR /B "*.7z"`) DO CALL :cleanup %%i %%j %%k %%l %%m %%n %%o
CD ..
GOTO :end

:cleanup
IF /i "%7"=="7z" CALL :clean %1_%2_%3_%4_%5 %6 && GOTO :eof
IF /i "%6"=="7z" CALL :clean %1_%2_%3_%4 %5 && GOTO :eof
IF /i "%5"=="7z" CALL :clean %1_%2_%3 %4 && GOTO :eof
IF /i "%4"=="7z" CALL :clean %1_%2 %3 && GOTO :eof
IF /i "%3"=="7z" CALL :clean %1 %2 && GOTO :eof
GOTO :eof

:clean
FOR /f "tokens=* usebackq" %%f IN (`DIR /B /O:N "%1_*.7z"`) DO SET "GOODFILE=%%f"
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
EXIT /B %ERRORLEVEL%
