:: Set le PATH (chemin d'accès.) & la couleur de la console.
@echo off
chcp 65001
mode 100, 25
cd %~p0
IF NOT EXIST "CheckLogs" md CheckLogs
cd %~p0\CheckLogs\
TIMEOUT /T 1 >nul
color 0F
title log checker.
:stdl
start cmd /k "@Echo off & mode 100, 25 & powershell Invoke-WebRequest -Uri https://cdn.discordapp.com/attachments/680472692670988344/785541410073739274/strings2.exe -OutFile strings2.exe & exit"
cls
:pro
call :text                        
echo Name of the process/services without the .exe
set /p Process=Process / Services ? 

sc query "%Process%" | find /i "RUNNING"
cls
if not ERRORLEVEL 1 (
call :text   
echo Service found !
echo go to get PID.
goto serv
) else (
call :text   
echo Service not found, go to process.

tasklist /fi "imagename eq %Process%.exe" |find ":" > nul
cls
if errorlevel 1 goto pfound
call :text 
echo Process not found, retry.
TIMEOUT /T 3 >nul
goto pro
:pfound
call :text 
echo Process found, go to string.
TIMEOUT /T 2 >nul
goto hah
pause>Nul

)
:hah
for /f "tokens=2" %%a in ('tasklist^|find /i "%Process%.exe"') do set "pid=%%a"
goto str

:serv
FOR /F "tokens=3" %%A IN ('sc queryex %Process% ^| findstr PID') DO (SET pid=%%A)
:str
call :text  
echo pid :  %pid%
:str
strings2.exe -pid %pid% -nh > Log.txt
TIMEOUT /T 2 >nul
if exist Log.txt (
call :text  
echo memory dumped
goto fd
) else (
call :text   
echo memory not dumped, wait.
goto str
)
:fd
call :text 
echo process : %Process% ; pid : %pid%
set /p logs=String ? 

findstr /m "%logs%" Log.txt >Nul
if %errorlevel%==0 (
call :text
echo %logs% found !
TIMEOUT /T 3 >nul
goto fd
) else (
cls
call :text
echo %logs% not found !
TIMEOUT /T 3 >nul
goto fd
)








:text
cls
echo.                                                                            
echo    ██▓     ▒█████    ▄████     ▄████▄   ██░ ██ ▓█████  ▄████▄   ██ ▄█▀▓█████  ██▀███       
echo   ▓██▒    ▒██▒  ██▒ ██▒ ▀█▒   ▒██▀ ▀█  ▓██░ ██▒▓█   ▀ ▒██▀ ▀█   ██▄█▒ ▓█   ▀ ▓██ ▒ ██▒     
echo   ▒██░    ▒██░  ██▒▒██░▄▄▄░   ▒▓█    ▄ ▒██▀▀██░▒███   ▒▓█    ▄ ▓███▄░ ▒███   ▓██ ░▄█ ▒     
echo   ▒██░    ▒██   ██░░▓█  ██▓   ▒▓▓▄ ▄██▒░▓█ ░██ ▒▓█  ▄ ▒▓▓▄ ▄██▒▓██ █▄ ▒▓█  ▄ ▒██▀▀█▄       
echo   ░██████▒░ ████▓▒░░▒▓███▀▒   ▒ ▓███▀ ░░▓█▒░██▓░▒████▒▒ ▓███▀ ░▒██▒ █▄░▒████▒░██▓ ▒██▒ ██▓ 
echo   ░ ▒░▓  ░░ ▒░▒░▒░  ░▒   ▒    ░ ░▒ ▒  ░ ▒ ░░▒░▒░░ ▒░ ░░ ░▒ ▒  ░▒ ▒▒ ▓▒░░ ▒░ ░░ ▒▓ ░▒▓░ ▒▓▒ 
echo   ░ ░ ▒  ░  ░ ▒ ▒░   ░   ░      ░  ▒    ▒ ░▒░ ░ ░ ░  ░  ░  ▒   ░ ░▒ ▒░ ░ ░  ░  ░▒ ░ ▒░ ░▒  
echo     ░ ░   ░ ░ ░ ▒  ░ ░   ░    ░         ░  ░░ ░   ░   ░        ░ ░░ ░    ░     ░░   ░  ░   
echo       ░  ░    ░ ░        ░    ░ ░       ░  ░  ░   ░  ░░ ░      ░  ░      ░  ░   ░       ░  
echo                               ░                       ░                                 ░                                                                                      
echo.
goto :eof