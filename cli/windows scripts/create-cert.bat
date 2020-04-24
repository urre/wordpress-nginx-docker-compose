@echo off
for /f "delims=" %%x in (..\..\.env) do (set "%%x")
echo %DOMAIN%
SET CERTS=..\..\certs
del /Q/S %CERTS%
md %CERTS%
powershell -Command "(gc local.conf) -replace '<DOMAIN>', '%DOMAIN%' | Out-File -encoding ASCII localhost.conf"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout %CERTS%\%DOMAIN%.key -out %CERTS%\%DOMAIN%.crt -config localhost.conf 
del localhost.conf
pause