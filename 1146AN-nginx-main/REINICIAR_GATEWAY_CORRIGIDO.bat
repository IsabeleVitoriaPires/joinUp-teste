@echo off
echo ====================================================================================================
echo REINICIANDO GATEWAY COM CORRECAO DE CORS
echo ====================================================================================================
echo.

echo [1/4] Fechando TODAS as janelas Java (feche as janelas CMD manualmente se necessario)...
timeout /t 3 /nobreak >nul

echo.
echo [2/4] Tentando matar processos Java...
taskkill /F /IM java.exe /T 2>nul

echo.
echo Aguardando 5 segundos para garantir que os processos foram encerrados...
timeout /t 5 /nobreak >nul

echo.
echo [3/4] Recompilando Gateway com correcao de CORS...
cd /d "C:\Users\isabe\sistema_eventos\1146AN-nginx-main\gateway-service"

REM Tentar deletar target
rmdir /S /Q target 2>nul

REM Compilar
call mvnw.cmd clean package -DskipTests

if errorlevel 1 (
    echo.
    echo ====================================================================================================
    echo ERRO AO COMPILAR!
    echo ====================================================================================================
    echo.
    echo SOLUCAO MANUAL:
    echo 1. FECHE TODAS AS JANELAS CMD DOS SERVICOS
    echo 2. Execute novamente este script
    echo.
    pause
    exit /b 1
)

echo.
echo [4/4] Iniciando Gateway corrigido...
echo.
echo ====================================================================================================
echo GATEWAY INICIANDO COM CORRECAO DE CORS
echo ====================================================================================================
echo.
echo Aguarde aparecer: "Started GatewayServiceApplication"
echo.

start "JoinUp - Gateway (CORS Corrigido)" cmd /c "java -jar target\gateway-service-0.0.1-SNAPSHOT.jar"

echo.
echo ====================================================================================================
echo GATEWAY REINICIADO!
echo ====================================================================================================
echo.
echo IMPORTANTE:
echo 1. Uma nova janela CMD foi aberta para o Gateway
echo 2. Aguarde 30 segundos para o Gateway registrar no Eureka
echo 3. Depois teste criar evento novamente no navegador
echo.
echo Para verificar se esta UP:
echo   http://localhost:8761
echo.
echo Agora voce precisa REINICIAR OS OUTROS SERVICOS tambem!
echo Execute: INICIAR_TODOS_SERVICOS.bat
echo.
pause
