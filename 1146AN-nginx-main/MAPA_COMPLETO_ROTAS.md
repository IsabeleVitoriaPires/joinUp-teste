# Mapa Completo de Rotas - Frontend → Gateway → Backend

## ARQUITETURA

```
FRONTEND (localhost:3000)
    ↓
GATEWAY (localhost:8080)
    ↓
┌─────────────────┬──────────────────┬──────────────────┐
│  AUTH-SERVICE   │  EVENT-SERVICE   │  TICKET-SERVICE  │
│   (port 8084)   │   (port 8083)    │   (port 8085)    │
└─────────────────┴──────────────────┴──────────────────┘
```

---

## 1. TELA: login.html

### Cadastro de Usuário
**Frontend:**
```javascript
POST http://localhost:8080/api/auth/register
Body: {
  "firstName": "João",
  "lastName": "Silva",
  "email": "joao@org.com",
  "password": "senha12345",
  "role": "ORGANIZER"
}
```

**Gateway:**
```yaml
Path: /api/auth/register
Rewrite: /users
Service: AUTH-SERVICE (lb://AUTH-SERVICE)
```

**Backend (Auth Service):**
```
POST http://localhost:8084/users
Controller: UserController.register()
```

### Login
**Frontend:**
```javascript
POST http://localhost:8080/api/auth/login
Body: {
  "email": "joao@org.com",
  "password": "senha12345"
}
```

**Gateway:**
```yaml
Path: /api/auth/login
Rewrite: /auth/login/password
Service: AUTH-SERVICE
```

**Backend:**
```
POST http://localhost:8084/auth/login/password
Controller: AuthController.loginWithPassword()
```

---

## 2. TELA: forgot-password.html

**Frontend:**
```javascript
POST http://localhost:8080/api/auth/password/reset/request
Body: {
  "email": "user@example.com"
}
```

**Gateway:**
```yaml
Path: /api/auth/password/reset/request
Rewrite: /auth/password/reset/request
Service: AUTH-SERVICE
```

**Backend:**
```
POST http://localhost:8084/auth/password/reset/request
Controller: AuthController.requestPasswordReset()
```

---

## 3. TELA: reset-password.html

**Frontend:**
```javascript
POST http://localhost:8080/api/auth/password/reset/confirm
Body: {
  "code": "123456",
  "newPassword": "novaSenha123"
}
```

**Gateway:**
```yaml
Path: /api/auth/password/reset/confirm
Rewrite: /auth/password/reset/confirm
Service: AUTH-SERVICE
```

**Backend:**
```
POST http://localhost:8084/auth/password/reset/confirm
Controller: AuthController.confirmPasswordReset()
```

---

## 4. TELA: index.html (Lista de Eventos)

**Frontend:**
```javascript
GET http://localhost:8080/api/events
```

**Gateway:**
```yaml
Path: /api/events/**
Service: EVENT-SERVICE (sem rewrite)
```

**Backend:**
```
GET http://localhost:8083/api/events
Controller: PublicEventController.listEvents()
```

---

## 5. TELA: criar-evento.html

**Frontend:**
```javascript
POST http://localhost:8080/api/organizer/events
Headers: {
  "Authorization": "Bearer JWT_TOKEN",
  "Content-Type": "application/json"
}
Body: {
  "name": "Festival",
  "description": "Descrição",
  "eventDate": "2025-06-15T20:00:00",
  "location": "Parque",
  "ticketPrice": 150.00,
  "totalTickets": 1000,
  "organizerId": "uuid-do-usuario"
}
```

**Gateway:**
```yaml
Path: /api/organizer/**
Service: EVENT-SERVICE (sem rewrite)
```

**Backend:**
```
POST http://localhost:8083/api/organizer/events
Controller: OrganizerEventController.createEvent()
REQUER: JWT Token com role ORGANIZER
```

---

## 6. TELA: evento-detalhes.html

**Frontend:**
```javascript
GET http://localhost:8080/api/events/{id}
```

**Gateway:**
```yaml
Path: /api/events/**
Service: EVENT-SERVICE
```

**Backend:**
```
GET http://localhost:8083/api/events/{id}
Controller: PublicEventController.getEventById()
```

---

## 7. TELA: comprar.html

**Frontend:**
```javascript
POST http://localhost:8080/api/tickets/purchases
Headers: {
  "Authorization": "Bearer JWT_TOKEN"
}
Body: {
  "eventId": "uuid-do-evento",
  "quantity": 2,
  "attendees": [
    {
      "name": "Maria",
      "email": "maria@test.com",
      "document": "12345678900"
    }
  ]
}
```

**Gateway:**
```yaml
Path: /api/tickets/**
Service: TICKET-SERVICE (sem rewrite)
```

**Backend:**
```
POST http://localhost:8085/api/tickets/purchases
Controller: PurchaseController.createPurchase()
REQUER: JWT Token
```

---

## 8. TELA: dashboard.html (Organizador)

### Listar Eventos do Organizador
**Frontend:**
```javascript
GET http://localhost:8080/api/organizer/events
Headers: {
  "Authorization": "Bearer JWT_TOKEN"
}
```

**Backend:**
```
GET http://localhost:8083/api/organizer/events
Controller: OrganizerEventController.listMyEvents()
```

### Dashboard Metrics
**Frontend:**
```javascript
GET http://localhost:8080/api/dashboard/organizer
Headers: {
  "Authorization": "Bearer JWT_TOKEN"
}
```

**Backend:**
```
GET http://localhost:8083/api/dashboard/organizer
Controller: DashboardController.getOrganizerDashboard()
```

---

## VERIFICAÇÃO DAS ROTAS DO GATEWAY

As rotas do Gateway estão configuradas em:
`gateway-service/src/main/resources/application.yml`

### Rotas Configuradas: ✅

```yaml
✅ /api/auth/register → AUTH-SERVICE /users
✅ /api/auth/login → AUTH-SERVICE /auth/login/password
✅ /api/auth/password/reset/request → AUTH-SERVICE
✅ /api/auth/password/reset/confirm → AUTH-SERVICE
✅ /api/events/** → EVENT-SERVICE
✅ /api/organizer/** → EVENT-SERVICE
✅ /api/dashboard/** → EVENT-SERVICE
✅ /api/tickets/** → TICKET-SERVICE
```

### CORS: ✅ Configurado
```yaml
allowedOrigins: "*"
allowedMethods: GET, POST, PUT, DELETE, OPTIONS
allowedHeaders: "*"
```

---

## CHECKLIST DE VERIFICAÇÃO

### Backend
- [ ] Service Discovery rodando (8761)
- [ ] Auth Service rodando (8084) e REGISTRADO
- [ ] Event Service rodando (8083) e REGISTRADO
- [ ] Ticket Service rodando (8085) e REGISTRADO
- [ ] Gateway rodando (8080) e REGISTRADO

### Testes de Conectividade
```cmd
# Gateway está UP?
curl http://localhost:8080/actuator/health

# Eureka está UP?
curl http://localhost:8761/

# Cadastro funciona?
curl -X POST http://localhost:8080/api/auth/register -H "Content-Type: application/json" -d "{\"firstName\":\"Test\",\"lastName\":\"User\",\"email\":\"test@test.com\",\"password\":\"senha12345\",\"role\":\"USER\"}"

# Listar eventos funciona?
curl http://localhost:8080/api/events
```

---

## RESUMO PORTAS

| Serviço | Porta | URL | Status Required |
|---------|-------|-----|-----------------|
| Frontend | 3000 | http://localhost:3000 | - |
| Gateway | 8080 | http://localhost:8080 | UP |
| Eureka | 8761 | http://localhost:8761 | UP |
| Auth | 8084 | http://localhost:8084 | Registered |
| Event | 8083 | http://localhost:8083 | Registered |
| Ticket | 8085 | http://localhost:8085 | Registered |

---

## PROBLEMA COMUM: Gateway não sobe

### Causas possíveis:
1. Porta 8080 já em uso
2. Eureka não está rodando
3. Erro de configuração no application.yml
4. JAR não compilado

### Solução:
```cmd
# 1. Parar tudo
taskkill /F /IM java.exe

# 2. Verificar porta 8080
netstat -ano | findstr :8080

# 3. Iniciar Eureka PRIMEIRO
cd service-discovery
java -jar target\service-discovery-0.0.1-SNAPSHOT.jar

# 4. Aguardar Eureka subir (ver "Started Eureka Server")

# 5. Iniciar Gateway
cd gateway-service
java -jar target\gateway-service-0.0.1-SNAPSHOT.jar

# 6. Ver logs - procure por ERROS
```

---

**As rotas estão CORRETAS. O problema é o Gateway não estar rodando!**

**Siga o GUIA_COMPLETO_INICIALIZACAO.md passo a passo.**
