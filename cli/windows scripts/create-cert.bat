@echo off
SET CERTS=..\..\certs
del /Q/S %CERTS%
md %CERTS%
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout %CERTS%\myapp.local.key -out %CERTS%\myapp.local.crt -config myapp.local.conf
 %CERTS%