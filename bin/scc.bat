@ECHO off
SETLOCAL ENABLEEXTENSIONS
SET SCPID=%RANDOM%
SET DIRNAME=%~dp0
java -mx2048m  -jar "%DIRNAME%\sc.jar" -restartArgsFile %TEMP%\restart%SCPID%.tmp %*
SET SC_EXIT_STATUS=%ERRORLEVEL%
if %SC_EXIT_STATUS% neq 33 goto exitsc
:tryagain
java -mx2048m  -jar "%DIRNAME%\sc.jar" -restartArgsFile %TEMP%\restart%SCPID%.tmp -restart
set SC_EXIT_STATUS=%errorlevel%
if %SC_EXIT_STATUS% equ 33 goto tryagain
:exitsc
EXIT /B %SC_EXIT_STATUS%
