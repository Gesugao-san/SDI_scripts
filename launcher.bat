
@ECHO OFF
@SETLOCAL ENABLEEXTENSIONS
SET "VERBOSE_OUTPUT=true"
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

ECHO. * * * * * * * * * * * * * * * * * * * * * * * * * * *
CHOICE /C 12349 /D 9 /T 10 /N /M "=> Please select option (1/2/3/4/[9]):"
ECHO. * [Debug] Choice position: %ERRORLEVEL%

IF "%ERRORLEVEL%"=="1" (
    @REM Starter
    ECHO. * You choiced: [1] SDI Starter
) ELSE IF "%ERRORLEVEL%"=="2" (
    @REM Driver Pack Cleanup
    ECHO. * You choiced: [2] Driver Pack Cleanup
) ELSE IF "%ERRORLEVEL%"=="3" (
    @REM Logs Cleanup
    ECHO. * You choiced: [3] Logs Cleanup
) ELSE IF "%ERRORLEVEL%"=="4" (
    @REM All driverpacks unpacker
    ECHO. * You choiced: [4] All driverpacks unpacker
) ELSE IF "%ERRORLEVEL%"=="5" (
    @REM Exit
    ECHO. * You choiced or timeouted: [9] Exit
) ELSE IF "%ERRORLEVEL%"=="0" (
    ECHO. * Choice process incorrupted by user via Ctrl-C.
) ELSE IF "%ERRORLEVEL%"=="255" (
    ECHO. * Unknown or unhandled error.
) ELSE (
    ECHO. * Error: choice position not defined.
)

ECHO.
PAUSE
