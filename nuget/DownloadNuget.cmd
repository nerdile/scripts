where nuget.exe >nul 2>nul || powershell -ExecutionPolicy Bypass -Command "wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile .\nuget.exe"
nuget.exe update -self

