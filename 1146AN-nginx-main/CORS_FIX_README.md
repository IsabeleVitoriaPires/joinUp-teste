# Solução Definitiva para CORS

## Problema
O Spring Cloud Gateway estava duplicando o header `Access-Control-Allow-Origin`, causando erro no navegador:
```
The 'Access-Control-Allow-Origin' header contains multiple values '*, *', but only one is allowed.
```

## Causa Raiz
Os controllers dos microservices (event-service e ticket-service) tinham anotações `@CrossOrigin(origins = "*")`, fazendo com que os serviços adicionassem headers CORS. O gateway também adicionava seus próprios headers CORS, resultando em duplicação.

## Solução Implementada

### 1. Remover CORS dos Microservices
Removidas todas as anotações `@CrossOrigin` dos controllers:
- event-service: PublicEventController, OrganizerEventController, DashboardController
- ticket-service: PurchaseController, MetricsController

**Importante:** Apenas o Gateway deve gerenciar CORS - os microservices backend não devem adicionar headers CORS.

### 2. Usar servidor HTTP local em vez de abrir o HTML diretamente (`file://`):

```bash
# No diretório frontend:
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/frontend

# Opção 1: Python
python3 -m http.server 3000

# Opção 2: Node.js (se instalado)
npx serve -p 3000

# Opção 3: PHP (se instalado)
php -S localhost:3000
```

Então acesse: **http://localhost:3000/login.html**

## Por que funciona?

- Origin `file://` é tratado como `null` pelo navegador
- Origin `http://localhost:3000` é um origin válido
- O CORS funciona corretamente com origins HTTP válidos

## Configuração CORS no Gateway

Arquivo: `gateway-service/src/main/resources/application.yml`

```yaml
spring:
  cloud:
    gateway:
      globalcors:
        corsConfigurations:
          '[/**]':
            allowedOrigins: "*"
            allowedMethods:
              - GET
              - POST
              - PUT
              - DELETE
              - OPTIONS
              - PATCH
            allowedHeaders: "*"
            maxAge: 3600
```

## Teste Rápido

```bash
# Iniciar sistema
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main
./start-all.sh

# Em outro terminal, iniciar frontend
cd frontend
python3 -m http.server 3000

# Abrir navegador
firefox http://localhost:3000/login.html
```

**Agora deve funcionar sem erros de CORS!**
