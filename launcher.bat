
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET "VERBOSE_OUTPUT=true"
SET SDIPath=%~dp0
CLS

IF %VERBOSE_OUTPUT% == true (
    ECHO.
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO. * Snappy Driver Installer                           *
    ECHO. *   Script Launcher                                 *
    ECHO. *                                                   *
    @REM ECHO. * Here you can select and run one of 4th scripts:   *
    ECHO. *   [1] SDI Starter ^(autodetecting architecture^);   *
    ECHO. *   [2] Driver Pack Cleanup;                        *
    ECHO. *   [3] Logs Cleanup;                               *
    ECHO. *   [4] All driverpacks unpacker ^(requires ~90GB^);  *
    ECHO. *   [9] Exit ^(10 second time-out^).                  *
    ECHO. *                                                   *
    ECHO. * Original by Gesugao-san                           *
    ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
    ECHO.
)

@REM https://stackoverflow.com/a/2763907
FOR /F "usebackq delims=" %%x IN ("%SDIPath%scripts\scripts.cfg") DO (SET "%%x")
IF NOT "%var1%" == "" (
    ECHO var1 = %var1%
) ELSE (
    ECHO No config
)

ENDLOCAL
ECHO Reading file "%SDIPath%scripts\scripts.cfg"
SET /A line_num=1
FOR /F "usebackq tokens=* delims=" %%z IN ("%SDIPath%scripts\scripts.cfg") DO (
    SET /A line_num+=1
    @REM https://stackoverflow.com/a/7006016
    SET str1=%%z
    SET str2=12
    IF NOT "x!str1:%str2%=!"=="x%str1%" (
        ECHO %line_num%: %%z
    ) ELSE (
        ECHO It not contains "%str2%"
    )
)
@SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
CHOICE /C 12349 /D 9 /T 10 /N /M "=> Please select option (1/2/3/4/[9]):"
ECHO. * [Debug] Choice position: %ERRORLEVEL%

IF "%ERRORLEVEL%" == "1" (
    @REM Starter
    ECHO. * You choiced: [1] SDI Starter
) ELSE IF "%ERRORLEVEL%" == "2" (
    @REM Driver Pack Cleanup
    ECHO. * You choiced: [2] Driver Pack Cleanup
) ELSE IF "%ERRORLEVEL%" == "3" (
    @REM Logs Cleanup
    ECHO. * You choiced: [3] Logs Cleanup
) ELSE IF "%ERRORLEVEL%" == "4" (
    @REM All driverpacks unpacker
    ECHO. * You choiced: [4] All driverpacks unpacker
) ELSE IF "%ERRORLEVEL%" == "5" (
    @REM Exit
    ECHO. * You choiced or timeouted: [9] Exit
) ELSE IF "%ERRORLEVEL%" == "0" (
    ECHO. * Choice process incorrupted by user via Ctrl-C.
) ELSE IF "%ERRORLEVEL%" == "255" (
    ECHO. * Unknown or unhandled error.
) ELSE (
    ECHO. * Error: choice position not defined.
)

:end
ECHO.
IF %VERBOSE_OUTPUT% == true TIMEOUT 10
EXIT /B %ERRORLEVEL%
ENDLOCAL
