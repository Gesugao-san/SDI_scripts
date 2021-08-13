
ECHO OFF
::Get the newest SDI_Rnnn.exe file
for /f "tokens=*" %%a in ('dir /b /od "%~dp0SDI_R*.exe"') do set "SDIEXE=%%a"

for /F %%i in ('dir /b drivers\*.7z') do %SDIEXE% -7z x drivers\%%i -y -odrivers\%%~ni
del indexes\SDI\unpacked.bin
echo -keepunpackedindex >> sdi.cfg

@REM https://sdi-tool.org/settings/
