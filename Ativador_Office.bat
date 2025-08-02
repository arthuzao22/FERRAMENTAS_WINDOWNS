@echo off
setlocal enabledelayedexpansion
color 1F
title Ativador Office 64bits - Interface Intuitiva

:: Verifica se o script está rodando como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo =============================
    echo  Solicitando permissao de administrador...
    echo =============================
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)


:MENU
cls
echo ===================================================
echo           ATIVADOR OFFICE
echo ===================================================
echo.
echo 1. Ativar Office
echo 2. Sair
echo.
choice /c 12 /n /m "Escolha uma opcao: "
if errorlevel 2 goto FIM
if errorlevel 1 goto ESCOLHE_BIT

:ESCOLHE_BIT
cls
echo ===================================================
echo  Seu Office e 32bits ou 64bits?
echo ===================================================
echo.
echo 1. 64 bits
echo 2. 32 bits
echo.
choice /c 12 /n /m "Escolha uma opcao: "
if errorlevel 2 set OFFICE_PATH=%ProgramFiles(x86)%\Microsoft Office\Office16&goto ATIVAR
if errorlevel 1 set OFFICE_PATH=%ProgramFiles%\Microsoft Office\Office16&goto ATIVAR


:ATIVAR
cls
echo Rodando como administrador...
cd /d "%OFFICE_PATH%"

echo.
echo [1/6] Inserindo licencas...
for /f %%x in ('dir /b "..\root\Licenses16\proplusvl_kms*.xrm-ms"') do (
    echo Instalando licenca: %%x
    cscript //nologo ospp.vbs /inslic:"..\root\Licenses16\%%x"
)

echo.
echo [2/6] Inserindo chave de produto...
cscript //nologo ospp.vbs /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99

echo.
echo [3/6] Removendo chaves antigas...
cscript //nologo ospp.vbs /unpkey:BTDRB >nul
cscript //nologo ospp.vbs /unpkey:KHGM9 >nul
cscript //nologo ospp.vbs /unpkey:CPQVG >nul

echo.
echo [4/6] Configurando servidor KMS...
cscript //nologo ospp.vbs /sethst:e8.us.to
cscript //nologo ospp.vbs /setprt:1688

echo.
echo [5/6] Ativando produto...
cscript //nologo ospp.vbs /act

echo.
echo [6/6] ===== ATIVACAO FINALIZADA =====
echo.
echo Pressione qualquer tecla para voltar ao menu...
pause >nul
goto MENU

:FIM
echo.
echo Obrigado por usar o Ativador Office!
timeout /t 2 >nul
exit
