@echo off
color 1F
title Desativar Modo de Assinatura de Teste - Interface Intuitiva
setlocal enabledelayedexpansion

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
echo    DESATIVAR MODO DE ASSINATURA DE TESTE (TESTSIGNING)
echo ===================================================
echo.
echo 1. Desativar e Reiniciar
echo 2. Sair
echo.
choice /c 12 /n /m "Escolha uma opcao: "
if errorlevel 2 goto FIM
if errorlevel 1 goto CONFIRMAR

:CONFIRMAR
cls
echo ---------------------------------------------------
echo Tem certeza que deseja desativar o modo de assinatura de teste?
echo Isso reiniciara o computador!
echo ---------------------------------------------------
echo 1. Sim, desativar e reiniciar
echo 2. Voltar ao menu
echo.
choice /c 12 /n /m "Confirme sua escolha: "
if errorlevel 2 goto MENU
if errorlevel 1 goto DESATIVAR

:DESATIVAR
cls
echo Desativando modo de assinatura de teste...
bcdedit -set TESTSIGNING OFF
echo.
echo O computador sera reiniciado em 10 segundos...
timeout /t 10 /nobreak >nul
shutdown /r /t 0

:FIM
echo.
echo Operacao cancelada. Pressione qualquer tecla para sair.
pause >nul
exit
