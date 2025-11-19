# 🚀 Como Iniciar o Sistema JoinUp

## ⚠️ PROBLEMA IDENTIFICADO

O erro "Verifique se o gateway está rodando na porta 8080" ocorre porque **os serviços não estão rodando**.

## ✅ SOLUÇÃO: Iniciar os Serviços

### Opção 1: Usando Docker (RECOMENDADO)

Se você tem Docker instalado:

```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main

# Compilar os serviços
mvn clean package -DskipTests -f auth-service/pom.xml
mvn clean package -DskipTests -f event-service/pom.xml
mvn clean package -DskipTests -f ticket-service/pom.xml
mvn clean package -DskipTests -f gateway-service/pom.xml
mvn clean package -DskipTests -f service-discovery/pom.xml

# Iniciar com Docker Compose
docker-compose up -d

# Verificar status
docker-compose ps

# Ver logs
docker-compose logs -f
```

**Aguarde 60 segundos** para todos os serviços iniciarem.

### Opção 2: Executar Localmente (5 Terminais)

Abra 5 terminais separados:

#### Terminal 1 - Eureka (Service Discovery)
```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/service-discovery
mvn spring-boot:run
```
Aguarde aparecer: "Started EurekaApplication"

#### Terminal 2 - Auth Service
```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/auth-service
mvn spring-boot:run
```
Aguarde aparecer: "Started AuthserviceApplication"

#### Terminal 3 - Event Service
```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/event-service
mvn spring-boot:run
```
Aguarde aparecer: "Started EventServiceApplication"

#### Terminal 4 - Ticket Service
```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/ticket-service
mvn spring-boot:run
```
Aguarde aparecer: "Started TicketServiceApplication"

#### Terminal 5 - Gateway
```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/gateway-service
mvn spring-boot:run
```
Aguarde aparecer: "Started GatewayServiceApplication"

---

## 🔍 Verificar se Está Funcionando

### 1. Testar Eureka
Abra o navegador em: http://localhost:8761

Você deve ver todos os serviços registrados:
- AUTH-SERVICE
- EVENT-SERVICE
- TICKET-SERVICE
- GATEWAY-SERVICE

### 2. Testar Gateway
```bash
curl http://localhost:8080/actuator/health
```

Deve retornar: `{"status":"UP"}`

### 3. Testar Endpoints

**Listar eventos (público):**
```bash
curl http://localhost:8080/api/events
```

**Registrar usuário:**
```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Teste",
    "lastName": "Usuario",
    "email": "teste@example.com",
    "password": "senha123",
    "role": "ORGANIZER"
  }'
```

---

## 🎨 Usar o Frontend

### 1. Abrir o Frontend

Navegue até:
```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/frontend
```

**Opção A - Abrir diretamente no navegador:**
```bash
# Firefox
firefox login.html &

# Chrome/Chromium
google-chrome login.html &
```

**Opção B - Usar servidor HTTP local:**
```bash
# Python 3
python3 -m http.server 3000

# Ou Node.js (se tiver instalado)
npx serve -p 3000
```

Depois acesse: http://localhost:3000/login.html

### 2. Cadastrar Organizador

1. Clique em "Cadastre-se"
2. Preencha:
   - Nome: João
   - Sobrenome: Organizador
   - Email: joao@org.com
   - Senha: senha123
   - Tipo: **Organizador (criar eventos)**
3. Clique em "Cadastrar"

### 3. Fazer Login

1. Email: joao@org.com
2. Senha: senha123
3. Clique em "Entrar"

### 4. Criar Evento

1. Clique em "Criar Evento"
2. Preencha os dados do evento
3. Clique em "Criar Evento"

**Agora deve funcionar!** ✅

---

## 🔧 CORREÇÃO APLICADA

### Problema de CORS Corrigido

**Antes:**
```java
corsConfig.setAllowedOriginPatterns(Collections.singletonList("*"));
```

**Depois:**
```java
corsConfig.setAllowedOriginPatterns(Arrays.asList(
    "http://localhost:*",
    "http://127.0.0.1:*",
    "file://*",
    "null"
));
```

Agora o CORS aceita:
- Qualquer porta no localhost (3000, 5500, 8080, etc)
- Arquivos abertos diretamente (file://)
- Requisições de origem null

---

## 🐛 Troubleshooting

### "Connection refused" no frontend
**Causa:** Gateway não está rodando
**Solução:** Inicie os serviços conforme instruções acima

### "401 Unauthorized" ao criar evento
**Causa:** Token JWT inválido ou expirado
**Solução:** Faça logout e login novamente

### "404 Not Found"
**Causa:** Rota incorreta ou serviço não registrado no Eureka
**Solução:**
1. Acesse http://localhost:8761
2. Verifique se todos os serviços estão UP
3. Aguarde 30 segundos para registro

### "CORS error" no navegador
**Causa:** Configuração de CORS incorreta (JÁ CORRIGIDO)
**Solução:** A correção foi aplicada automaticamente

### Porta 8080 já em uso
**Causa:** Outro processo usando a porta
**Solução:**
```bash
# Linux
sudo lsof -i :8080
sudo kill -9 <PID>

# Ou mude a porta no application.yml
```

---

## 📊 Portas do Sistema

| Serviço | Porta | URL |
|---------|-------|-----|
| Eureka | 8761 | http://localhost:8761 |
| Gateway | 8080 | http://localhost:8080 |
| Auth | 8084 | http://localhost:8084 |
| Event | 8083 | http://localhost:8083 |
| Ticket | 8085 | http://localhost:8085 |
| Frontend | 3000 | http://localhost:3000 |
| PostgreSQL (auth) | 5432 | jdbc:postgresql://localhost:5432/auth_db |
| PostgreSQL (events) | 5433 | jdbc:postgresql://localhost:5433/events_db |
| PostgreSQL (tickets) | 5434 | jdbc:postgresql://localhost:5434/tickets_db |

---

**Última atualização:** 2025-11-18
