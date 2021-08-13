
@ECHO OFF

@REM Get the newest SDI_Rnnn.exe file
FOR /f "tokens=*" %%a IN ('DIR /b /od "%~dp0SDI_R*.exe"') DO SET "SDIEXE=%%a"

FOR /F %%i IN ('DIR /b drivers\*.7z') DO %SDIEXE% -7z x drivers\%%i -y -odrivers\%%~ni
DEL ".\indexes\SDI\unpacked.bin"
ECHO -keepunpackedindex >> sdi.cfg

@REM https://sdi-tool.org/settings/
