@echo off
title Otimizador de Sistema - Arthur
color 0A

:: Solicita permissão de administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Solicitando permissao de administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo ========================================
echo Iniciando Otimizador do Windows...
echo Autor: Arthur Dos Reis Gonçalves
echo ========================================
echo.

:: 1. Executar verificação de vírus com o Windows Defender
echo Iniciando varredura completa com o Windows Defender...
echo.
powershell -Command "Start-MpScan -ScanType FullScan"

:: 2. Abrir Programas e Recursos para desinstalar softwares
echo.
echo Abrindo Programas e Recursos para desinstalacao de programas...
start appwiz.cpl

:: 3. Desativar efeitos visuais para melhor desempenho
echo.
echo Ajustando efeitos visuais para melhor desempenho...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Performance\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

:: 4. Executar limpeza de disco
echo.
echo Abrindo Limpeza de Disco...
cleanmgr /sagerun:1

:: 5. Mensagem sobre upgrade de RAM
echo.
echo ========================================
echo IMPORTANTE:
echo Se o desempenho ainda estiver baixo, considere adicionar mais memoria RAM ao seu sistema.
echo Consulte o manual do fabricante para especificacoes.
echo ========================================
echo.

pause
exit
