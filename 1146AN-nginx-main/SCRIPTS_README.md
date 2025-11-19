# 🚀 Scripts de Gerenciamento do Sistema JoinUp

Este diretório contém scripts bash para facilitar o gerenciamento dos microserviços.

## 📋 Scripts Disponíveis

### 1. `start-all.sh` - Iniciar Todos os Serviços

**Descrição:** Compila (se necessário) e inicia todos os 5 microserviços em ordem correta.

**Uso:**
```bash
./start-all.sh
```

**O que faz:**
1. ✅ Verifica pré-requisitos (Java 17+, Maven)
2. ✅ Oferece opção de recompilar serviços
3. ✅ Inicia serviços em ordem:
   - Service Discovery (Eureka) - porta 8761
   - Auth Service - porta 8084
   - Event Service - porta 8083
   - Ticket Service - porta 8085
   - Gateway - porta 8080
4. ✅ Aguarda cada serviço iniciar
5. ✅ Verifica health dos serviços
6. ✅ Mostra resumo e URLs úteis

**Saída:**
- Logs salvos em: `logs/<service-name>.log`
- PIDs salvos em: `.service_pids`

**Tempo estimado:** 2-3 minutos

---

### 2. `stop-all.sh` - Parar Todos os Serviços

**Descrição:** Para todos os microserviços de forma graceful.

**Uso:**
```bash
./stop-all.sh
```

**O que faz:**
1. ✅ Lê PIDs salvos em `.service_pids`
2. ✅ Para cada serviço gracefully (`SIGTERM`)
3. ✅ Se não parar em 10s, força parada (`SIGKILL`)
4. ✅ Verifica se portas foram liberadas
5. ✅ Remove arquivo de PIDs

**Saída:**
- Resumo de serviços parados
- Alertas se alguma porta ainda estiver em uso

---

### 3. `check-health.sh` - Verificar Status do Sistema

**Descrição:** Verifica status detalhado de todos os serviços.

**Uso:**
```bash
./check-health.sh
```

**O que verifica:**
1. ✅ Processos em execução (PID, memória, CPU)
2. ✅ Health endpoints (`/actuator/health`)
3. ✅ Serviços registrados no Eureka
4. ✅ Endpoints principais via Gateway
5. ✅ Status das portas
6. ✅ Estatísticas do sistema

**Saída:**
- Status colorido de cada componente
- Dicas e comandos úteis

---

## 🎯 Fluxo de Uso Típico

### Primeira Vez

```bash
# 1. Iniciar sistema
./start-all.sh

# 2. Aguardar mensagem de sucesso
# (2-3 minutos)

# 3. Verificar status
./check-health.sh

# 4. Acessar Eureka Dashboard
firefox http://localhost:8761

# 5. Abrir frontend
firefox frontend/login.html
```

### Desenvolvimento Diário

```bash
# Iniciar
./start-all.sh

# Trabalhar...

# Verificar se tudo está OK
./check-health.sh

# Parar ao final do dia
./stop-all.sh
```

### Debug de Problemas

```bash
# Ver logs em tempo real
tail -f logs/gateway-service.log

# Verificar status detalhado
./check-health.sh

# Reiniciar tudo
./stop-all.sh
./start-all.sh
```

---

## 📁 Estrutura de Arquivos Gerada

Após executar os scripts, você terá:

```
1146AN-nginx-main/
├── start-all.sh           # Script de inicialização
├── stop-all.sh            # Script de parada
├── check-health.sh        # Script de verificação
├── .service_pids          # PIDs dos serviços (criado automaticamente)
└── logs/                  # Diretório de logs (criado automaticamente)
    ├── service-discovery.log
    ├── auth-service.log
    ├── event-service.log
    ├── ticket-service.log
    └── gateway-service.log
```

---

## 🔧 Solução de Problemas

### Erro: "Maven não encontrado"

**Solução:**
```bash
# Ubuntu/Debian
sudo apt install maven

# Fedora
sudo dnf install maven

# Verificar
mvn --version
```

### Erro: "Java 17 ou superior necessário"

**Solução:**
```bash
# Ubuntu/Debian
sudo apt install openjdk-17-jdk

# Fedora
sudo dnf install java-17-openjdk-devel

# Verificar
java -version
```

### Erro: "Porta 8080 já está em uso"

**Solução:**
```bash
# Encontrar processo
lsof -ti:8080

# Parar processo
kill $(lsof -ti:8080)

# Ou parar tudo
./stop-all.sh
```

### Serviço não inicia

**Diagnóstico:**
```bash
# Ver log do serviço
cat logs/<service-name>.log

# Ver últimas linhas
tail -50 logs/<service-name>.log

# Acompanhar em tempo real
tail -f logs/<service-name>.log
```

### Serviço não registra no Eureka

**Solução:**
1. Verifique se Eureka está rodando: `curl http://localhost:8761`
2. Aguarde 30-60 segundos
3. Verifique logs: `tail logs/service-discovery.log`

---

## 🎨 Saída Colorida

Os scripts usam cores para facilitar visualização:

- 🟢 **Verde**: Sucesso / UP / OK
- 🔴 **Vermelho**: Erro / DOWN / Falha
- 🟡 **Amarelo**: Aviso / Aguardando
- 🔵 **Azul**: Informação / Ação
- 🔷 **Ciano**: Cabeçalhos / Seções

---

## ⚙️ Configurações Avançadas

### Mudar Tempo de Espera

Edite `start-all.sh` e ajuste:

```bash
# Linha ~130
start_service "auth-service" "auth-service" 8084 10
#                                                 ^^ segundos
```

### Desabilitar Recompilação Automática

Edite `start-all.sh` e comente:

```bash
# compile_if_needed "service-discovery" "Service Discovery"
```

### Logs em Arquivo Único

```bash
# Redirecionar todos para um arquivo
./start-all.sh > system.log 2>&1
```

---

## 📊 Monitoramento Contínuo

### Ver logs de todos os serviços

```bash
# Instalar multitail (opcional)
sudo apt install multitail

# Ver todos os logs
multitail logs/*.log
```

### Script de monitoramento

```bash
# Criar arquivo watch-health.sh
cat > watch-health.sh << 'EOF'
#!/bin/bash
while true; do
    clear
    ./check-health.sh
    sleep 5
done
EOF

chmod +x watch-health.sh
./watch-health.sh
```

---

## 🐳 Alternativa: Docker Compose

Se preferir usar Docker:

```bash
# Compilar
mvn clean package -DskipTests

# Iniciar com Docker
docker-compose up -d

# Parar
docker-compose down

# Ver logs
docker-compose logs -f
```

---

## 🔗 Links Úteis Após Inicialização

| Serviço | URL |
|---------|-----|
| Eureka Dashboard | http://localhost:8761 |
| Gateway Health | http://localhost:8080/actuator/health |
| Listar Eventos | http://localhost:8080/api/events |
| Frontend | file:///home/jfranco/code/joinUp-teste/1146AN-nginx-main/frontend/login.html |

---

## 📝 Notas

- Scripts foram testados em Linux (Ubuntu/Debian/Fedora)
- Requerem `bash`, `lsof`, `curl` instalados
- PIDs são salvos e gerenciados automaticamente
- Logs rotacionam automaticamente a cada execução

---

**Última atualização:** 2025-11-18
