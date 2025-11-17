# JoinUp - Sistema de Gerenciamento de Eventos

Sistema completo de gerenciamento de eventos com autenticação, criação de eventos, venda de ingressos e dashboard de organizador.

## Arquitetura

- **Service Discovery (Eureka)**: Porta 8761
- **Auth Service**: Porta 8084 - Autenticação e gerenciamento de usuários
- **Event Service**: Porta 8083 - Gerenciamento de eventos
- **Ticket Service**: Porta 8085 - Venda e gerenciamento de ingressos
- **Gateway**: Porta 8080 - Ponto de entrada único para o frontend

## Pré-requisitos

- JDK 17 instalado em: `C:\Program Files\Java\jdk-17`
- Maven (ou usar os wrappers mvnw incluídos)

## Como iniciar o sistema

### 1. Compilar todos os serviços (OBRIGATÓRIO na primeira vez)

```bash
BUILD_ALL_SERVICES.bat
```

Este script compila todos os 5 serviços e cria os JARs necessários.

### 2. Iniciar todos os serviços

```bash
INICIAR_TODOS_SERVICOS.bat
```

Isso abrirá 5 janelas CMD, uma para cada serviço. Aguarde 30-60 segundos para tudo inicializar.

### 3. Verificar se está funcionando

- Acesse: http://localhost:8761
- Verifique se os 4 serviços aparecem registrados no Eureka:
  - AUTH-SERVICE
  - EVENT-SERVICE
  - TICKET-SERVICE
  - GATEWAY-SERVICE

### 4. Acessar o frontend

Você tem duas opções:

**Opção 1 - Via Gateway (recomendado):**
- Sirva os arquivos em `frontend/` com um servidor HTTP simples
- Ou abra diretamente no navegador

**Opção 2 - Servidor local:**
```bash
cd frontend
python -m http.server 3000
```
Depois acesse: http://localhost:3000

## Funcionalidades implementadas

### Autenticação (Auth Service)

✅ **Cadastro de usuário**
- Endpoint: `POST /api/auth/register`
- Campos: firstName, lastName, email, password, role (USER ou ORGANIZER)

✅ **Login**
- Endpoint: `POST /api/auth/login`
- Retorna: JWT token + dados do usuário

✅ **Recuperação de senha**
- Solicitar código: `POST /api/auth/password/reset/request`
- Confirmar reset: `POST /api/auth/password/reset/confirm`
- Código de 6 dígitos enviado por email (em dev, aparece no console)

### Eventos (Event Service)

✅ **Listar eventos** (público)
- Endpoint: `GET /api/events`

✅ **Criar evento** (somente ORGANIZER)
- Endpoint: `POST /api/organizer/events`

✅ **Dashboard do organizador**
- Endpoint: `GET /api/dashboard/organizer`
- Mostra eventos criados com métricas

### Ingressos (Ticket Service)

✅ **Comprar ingressos** (usuário autenticado)
- Endpoint: `POST /api/tickets/purchases`

✅ **Listar minhas compras**
- Endpoint: `GET /api/tickets/purchases/user`

## Fluxo de teste completo

### 1. Cadastrar usuário organizador

```http
POST http://localhost:8080/api/auth/register
Content-Type: application/json

{
  "firstName": "João",
  "lastName": "Silva",
  "email": "joao@organizador.com",
  "password": "senha12345",
  "role": "ORGANIZER"
}
```

### 2. Fazer login

```http
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{
  "email": "joao@organizador.com",
  "password": "senha12345"
}
```

Guarde o `accessToken` retornado.

### 3. Criar evento (como organizador)

```http
POST http://localhost:8080/api/organizer/events
Authorization: Bearer SEU_TOKEN_AQUI
Content-Type: application/json

{
  "name": "Festival de Música 2025",
  "description": "O maior festival do ano",
  "startTime": "2025-06-15T20:00:00",
  "endTime": "2025-06-15T23:59:00",
  "location": "Parque Municipal",
  "ticketsAvailable": 1000,
  "pricePerTicket": 150.00
}
```

### 4. Cadastrar usuário normal

```http
POST http://localhost:8080/api/auth/register
Content-Type: application/json

{
  "firstName": "Maria",
  "lastName": "Santos",
  "email": "maria@user.com",
  "password": "senha12345",
  "role": "USER"
}
```

### 5. Comprar ingresso (como usuário)

Faça login com o usuário normal, depois:

```http
POST http://localhost:8080/api/tickets/purchases
Authorization: Bearer TOKEN_DO_USUARIO
Content-Type: application/json

{
  "eventId": "UUID_DO_EVENTO",
  "quantity": 2,
  "attendees": [
    {
      "name": "Maria Santos",
      "email": "maria@user.com",
      "document": "12345678900"
    },
    {
      "name": "Pedro Costa",
      "email": "pedro@user.com",
      "document": "98765432100"
    }
  ]
}
```

## Recuperação de senha

### Pelo frontend:
1. Clique em "Esqueci minha senha" no login
2. Digite seu email
3. Verifique o código no console do auth-service
4. Digite o código de 6 dígitos + nova senha

### Via API:
```http
# 1. Solicitar código
POST http://localhost:8080/api/auth/password/reset/request
Content-Type: application/json

{
  "email": "usuario@exemplo.com"
}

# 2. Verificar código no console do auth-service
# Aparecerá algo como:
# [DEV] Codigo de Verificacao: 123456

# 3. Redefinir senha
POST http://localhost:8080/api/auth/password/reset/confirm
Content-Type: application/json

{
  "code": "123456",
  "newPassword": "novaSenha123"
}
```

## Para parar os serviços

```bash
PARAR_TODOS_SERVICOS.bat
```

Ou feche manualmente as 5 janelas CMD que foram abertas.

## Troubleshooting

### Erro: "Java não encontrado"
- Verifique se o JDK 17 está instalado em `C:\Program Files\Java\jdk-17`
- Ou ajuste a variável `JAVA_HOME` nos scripts .bat

### Erro: "JAR não encontrado"
- Execute `BUILD_ALL_SERVICES.bat` primeiro

### Serviços não aparecem no Eureka
- Aguarde mais tempo (até 60 segundos)
- Verifique se não há conflito de portas
- Verifique os logs nas janelas CMD de cada serviço

### Frontend não carrega
- Certifique-se que todos os serviços estão rodando
- Verifique se o Gateway está na porta 8080
- Abra o console do navegador para ver erros de CORS ou conexão

## Estrutura de portas

| Serviço | Porta |
|---------|-------|
| Eureka (Service Discovery) | 8761 |
| Gateway | 8080 |
| Auth Service | 8084 |
| Event Service | 8083 |
| Ticket Service | 8085 |

## Endpoints principais

### Auth
- `POST /api/auth/register` - Cadastro
- `POST /api/auth/login` - Login
- `POST /api/auth/password/reset/request` - Solicitar código de reset
- `POST /api/auth/password/reset/confirm` - Confirmar reset de senha

### Events
- `GET /api/events` - Listar eventos (público)
- `POST /api/organizer/events` - Criar evento (ORGANIZER)
- `GET /api/dashboard/organizer` - Dashboard (ORGANIZER)

### Tickets
- `POST /api/tickets/purchases` - Comprar ingressos
- `GET /api/tickets/purchases/user` - Minhas compras

---

**Desenvolvido com Spring Boot + Microserviços + React**
