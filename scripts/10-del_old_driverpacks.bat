
@ECHO OFF
ECHO Snappy Driver Installer
ECHO Driver Pack Cleanup
ECHO by Computer Bloke
ECHO.

@SETLOCAL ENABLEEXTENSIONS
@CD /d "%~dp0/drivers"
ATTRIB *.* -R
FOR /f "tokens=1,2,3,4,5,6,7 delims=_. usebackq" %%i IN (`DIR /b *.7z`) DO CALL :cleanup %%i %%j %%k %%l %%m %%n %%o
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
FOR /f "tokens=* usebackq" %%f IN (`DIR /b /on "%1_*.7z"`) DO SET "GOODFILE=%%f"
ECHO Keeping most recent driver file: %GOODFILE%
FOR %%f IN (%1_*.7z) DO IF NOT "%%f"=="%GOODFILE%" ECHO "%%f" & DEL "%%f"
GOTO :eof

:end
