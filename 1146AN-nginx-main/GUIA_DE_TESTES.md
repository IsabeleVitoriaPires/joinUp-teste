# Guia Completo de Testes - JoinUp

## Passo 1: Iniciar o Sistema

### 1.1 Compilar todos os serviços (se ainda não fez)
```bash
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main
BUILD_ALL_SERVICES.bat
```
Aguarde até aparecer "TODOS OS SERVICOS FORAM COMPILADOS COM SUCESSO!"

### 1.2 Iniciar todos os serviços
```bash
INICIAR_TODOS_SERVICOS.bat
```

**Importante**: 5 janelas CMD vão abrir. **NÃO FECHE NENHUMA!**

### 1.3 Aguardar inicialização
Aguarde **60 segundos** (1 minuto) para todos os serviços iniciarem.

### 1.4 Verificar se está tudo funcionando
1. Abra o navegador
2. Acesse: **http://localhost:8761**
3. Você deve ver esta tela do Eureka:

```
Instances currently registered with Eureka
Application                AMIs        Availability Zones      Status
AUTH-SERVICE               n/a (1)     (1)                     UP (1)
EVENT-SERVICE              n/a (1)     (1)                     UP (1)
GATEWAY-SERVICE            n/a (1)     (1)                     UP (1)
TICKET-SERVICE             n/a (1)     (1)                     UP (1)
```

**Se todos mostrarem "UP"**, está tudo certo! ✅

---

## Passo 2: Testar via Frontend (Recomendado)

### 2.1 Abrir o frontend
1. Navegue até: `C:\Users\isabe\sistema_eventos\1146AN-nginx-main\frontend`
2. Clique com botão direito em **login.html**
3. Escolha "Abrir com" → Seu navegador preferido

Ou abra diretamente:
- Chrome: Arraste `login.html` para o navegador
- Firefox: Arquivo → Abrir arquivo → Selecione `login.html`

### 2.2 Cadastrar Organizador

1. Na página de login, clique em **"Cadastre-se"**
2. Preencha:
   - **Primeiro Nome**: João
   - **Sobrenome**: Silva
   - **Email**: joao@organizador.com
   - **Senha**: senha12345
   - **Tipo de Conta**: **Organizador (criar eventos)**
3. Clique em **"Cadastrar"**
4. Deve aparecer: "Cadastro realizado com sucesso!"
5. Aguarde ser redirecionado para o login

### 2.3 Fazer Login como Organizador

1. Digite:
   - **Email**: joao@organizador.com
   - **Senha**: senha12345
2. Clique em **"Entrar"**
3. Você deve ser redirecionado para `index.html`
4. No canto superior direito deve aparecer: "Olá, João"

### 2.4 Criar um Evento

1. Clique no botão **"Criar Evento"** (no topo da página)
2. Preencha:
   - **Nome do Evento**: Festival de Música 2025
   - **Descrição**: O maior festival do ano com as melhores bandas
   - **Data de Início**: (escolha uma data futura, exemplo: 15/06/2025)
   - **Hora de Início**: 20:00
   - **Data de Término**: (mesma data)
   - **Hora de Término**: 23:59
   - **Local**: Parque Municipal - Centro
   - **Ingressos Disponíveis**: 1000
   - **Preço por Ingresso**: 150.00
3. Clique em **"Criar Evento"**
4. Deve aparecer: "Evento criado com sucesso!"
5. Você será redirecionado para a lista de eventos

### 2.5 Ver Dashboard do Organizador

1. Clique em **"Dashboard"** (no menu superior)
2. Você verá:
   - Total de eventos criados
   - Total de ingressos vendidos
   - Receita total
   - Lista dos seus eventos com métricas

### 2.6 Fazer Logout

1. Clique em **"Sair"** no menu superior
2. Você volta para a página inicial (sem estar logado)

### 2.7 Cadastrar Usuário Normal

1. Vá para a página de login: clique em **"Login"** no menu
2. Clique em **"Cadastre-se"**
3. Preencha:
   - **Primeiro Nome**: Maria
   - **Sobrenome**: Santos
   - **Email**: maria@user.com
   - **Senha**: senha12345
   - **Tipo de Conta**: **Usuário Normal (participar de eventos)**
4. Clique em **"Cadastrar"**
5. Aguarde o redirecionamento para o login

### 2.8 Fazer Login como Usuário

1. Digite:
   - **Email**: maria@user.com
   - **Senha**: senha12345
2. Clique em **"Entrar"**

### 2.9 Comprar Ingresso

1. Na lista de eventos, encontre o "Festival de Música 2025"
2. Clique em **"Ver Detalhes"**
3. Você verá todas as informações do evento
4. Clique em **"Comprar Ingressos"**
5. Escolha a quantidade: **2** (por exemplo)
6. Preencha os dados dos participantes:

   **Participante 1:**
   - Nome: Maria Santos
   - Email: maria@user.com
   - CPF/Documento: 12345678900

   **Participante 2:**
   - Nome: Pedro Costa
   - Email: pedro@user.com
   - CPF/Documento: 98765432100

7. Clique em **"Confirmar Compra"**
8. Deve aparecer: "Compra realizada com sucesso!"

### 2.10 Ver Meus Ingressos

1. Clique em **"Meus Ingressos"** no menu
2. Você verá:
   - Código da compra
   - Nome do evento
   - Quantidade de ingressos
   - Valor total pago
   - Status da compra
   - Lista de participantes

### 2.11 Testar Recuperação de Senha

1. Faça logout
2. Na página de login, clique em **"Esqueci minha senha"**
3. Digite: maria@user.com
4. Clique em **"Enviar Código"**
5. **IMPORTANTE**: Vá até a janela CMD do **"JoinUp - Auth Service"**
6. Você verá algo assim:
   ```
   =================================================
   [DEV] Password Reset Code para: maria@user.com
   [DEV] Codigo de Verificacao: 456789
   [DEV] Este codigo expira em 15 minutos
   =================================================
   ```
7. Copie o código de 6 dígitos
8. Volte para o navegador
9. Digite o código: **456789**
10. Digite a nova senha: **novaSenha123**
11. Confirme a senha: **novaSenha123**
12. Clique em **"Redefinir Senha"**
13. Deve aparecer: "Senha redefinida com sucesso!"
14. Faça login com a nova senha para confirmar

---

## Passo 3: Testar via API (Postman/Insomnia/cURL)

### 3.1 Instalar ferramenta de testes (escolha uma)

**Opção 1 - Postman** (Recomendado)
- Download: https://www.postman.com/downloads/
- Instale e abra

**Opção 2 - Insomnia**
- Download: https://insomnia.rest/download
- Instale e abra

**Opção 3 - cURL** (linha de comando)
- Já vem com Windows 10+

### 3.2 Testar endpoints

Vou usar exemplos com cURL (funciona no CMD do Windows):

#### A) Cadastrar usuário organizador
```bash
curl -X POST http://localhost:8080/api/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"firstName\":\"João\",\"lastName\":\"Silva\",\"email\":\"joao@teste.com\",\"password\":\"senha12345\",\"role\":\"ORGANIZER\"}"
```

**Resposta esperada:**
```json
{
  "id": "uuid-aqui",
  "firstName": "João",
  "lastName": "Silva",
  "email": "joao@teste.com",
  "role": "ORGANIZER"
}
```

#### B) Fazer login
```bash
curl -X POST http://localhost:8080/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"joao@teste.com\",\"password\":\"senha12345\"}"
```

**Resposta esperada:**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresIn": 3600,
  "user": {
    "id": "uuid-aqui",
    "firstName": "João",
    "lastName": "Silva",
    "email": "joao@teste.com",
    "role": "ORGANIZER"
  }
}
```

**Copie o `accessToken` para usar nos próximos passos!**

#### C) Criar evento (substituir TOKEN_AQUI)
```bash
curl -X POST http://localhost:8080/api/organizer/events ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer TOKEN_AQUI" ^
  -d "{\"name\":\"Show de Rock\",\"description\":\"Melhor show do ano\",\"startTime\":\"2025-06-15T20:00:00\",\"endTime\":\"2025-06-15T23:59:00\",\"location\":\"Estádio Municipal\",\"ticketsAvailable\":5000,\"pricePerTicket\":200.00}"
```

**Resposta esperada:**
```json
{
  "id": "uuid-do-evento",
  "name": "Show de Rock",
  "description": "Melhor show do ano",
  ...
}
```

**Copie o `id` do evento!**

#### D) Listar eventos (público - sem token)
```bash
curl http://localhost:8080/api/events
```

#### E) Cadastrar usuário normal
```bash
curl -X POST http://localhost:8080/api/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"firstName\":\"Maria\",\"lastName\":\"Santos\",\"email\":\"maria@teste.com\",\"password\":\"senha12345\",\"role\":\"USER\"}"
```

#### F) Login como usuário normal
```bash
curl -X POST http://localhost:8080/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"maria@teste.com\",\"password\":\"senha12345\"}"
```

**Copie o novo `accessToken`!**

#### G) Comprar ingressos (substituir TOKEN e EVENT_ID)
```bash
curl -X POST http://localhost:8080/api/tickets/purchases ^
  -H "Content-Type: application/json" ^
  -H "Authorization: Bearer TOKEN_DO_USUARIO" ^
  -d "{\"eventId\":\"EVENT_ID_AQUI\",\"quantity\":2,\"attendees\":[{\"name\":\"Maria Santos\",\"email\":\"maria@teste.com\",\"document\":\"12345678900\"},{\"name\":\"João Silva\",\"email\":\"joao@teste.com\",\"document\":\"98765432100\"}]}"
```

#### H) Ver minhas compras
```bash
curl http://localhost:8080/api/tickets/purchases/user ^
  -H "Authorization: Bearer TOKEN_DO_USUARIO"
```

#### I) Solicitar recuperação de senha
```bash
curl -X POST http://localhost:8080/api/auth/password/reset/request ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"maria@teste.com\"}"
```

**Veja o código na janela do Auth Service!**

#### J) Confirmar reset de senha
```bash
curl -X POST http://localhost:8080/api/auth/password/reset/confirm ^
  -H "Content-Type: application/json" ^
  -d "{\"code\":\"123456\",\"newPassword\":\"novaSenha999\"}"
```

---

## Passo 4: Verificar Logs e Debug

### 4.1 Verificar logs de cada serviço

Cada janela CMD mostra os logs do serviço:

**Service Discovery (Eureka)**
- Deve mostrar: "Started Eureka Server"
- Porta: 8761

**Auth Service**
- Deve mostrar: "Started AuthserviceApplication"
- Porta: 8084
- Aqui aparecem os códigos de recuperação de senha

**Event Service**
- Deve mostrar: "Started EventServiceApplication"
- Porta: 8083

**Ticket Service**
- Deve mostrar: "Started TicketServiceApplication"
- Porta: 8085

**Gateway**
- Deve mostrar: "Started GatewayServiceApplication"
- Porta: 8080

### 4.2 Verificar erros comuns

**Erro: "Connection refused"**
- Solução: Aguarde mais tempo (60 segundos)
- Verifique se o serviço subiu na janela CMD

**Erro: "401 Unauthorized"**
- Solução: Você esqueceu de passar o token JWT
- Ou o token expirou (faça login novamente)

**Erro: "404 Not Found"**
- Solução: Verifique se a URL está correta
- Lembre-se que rotas passam pelo Gateway (porta 8080)

**Erro: "Código inválido ou expirado"**
- Solução: Solicite um novo código (expira em 15 minutos)

---

## Passo 5: Checklist de Testes Completo

Use esta lista para garantir que testou tudo:

### Autenticação
- [ ] Cadastrar usuário ORGANIZER
- [ ] Cadastrar usuário USER
- [ ] Login com credenciais corretas
- [ ] Login com credenciais erradas (deve dar erro)
- [ ] Logout
- [ ] Solicitar código de recuperação de senha
- [ ] Ver código no log do Auth Service
- [ ] Redefinir senha com código correto
- [ ] Tentar usar código expirado (aguarde 15 minutos)
- [ ] Login com nova senha

### Eventos (como ORGANIZER)
- [ ] Criar evento
- [ ] Listar eventos criados no dashboard
- [ ] Ver métricas do evento
- [ ] Verificar total de ingressos disponíveis

### Eventos (como público/USER)
- [ ] Listar todos os eventos
- [ ] Ver detalhes de um evento
- [ ] Verificar preço e disponibilidade

### Ingressos (como USER)
- [ ] Comprar 1 ingresso
- [ ] Comprar múltiplos ingressos (2+)
- [ ] Preencher dados dos participantes
- [ ] Ver confirmação de compra
- [ ] Listar minhas compras
- [ ] Ver código do ingresso

### Sistema
- [ ] Verificar Eureka (todos os serviços UP)
- [ ] Verificar CORS (frontend funciona)
- [ ] Verificar JWT (token válido)
- [ ] Verificar rotas do Gateway

---

## Passo 6: Para Parar o Sistema

Quando terminar de testar:

```bash
PARAR_TODOS_SERVICOS.bat
```

Ou feche manualmente as 5 janelas CMD.

---

## Troubleshooting

### Problema: "Nenhum evento aparece"
**Solução**: Certifique-se que:
1. Você criou pelo menos 1 evento como ORGANIZER
2. Aguardou alguns segundos após criar
3. Atualizou a página

### Problema: "Não consigo comprar ingresso"
**Solução**: Verifique:
1. Você está logado como USER (não ORGANIZER)
2. O evento tem ingressos disponíveis
3. Você preencheu todos os dados dos participantes

### Problema: "Código de recuperação não funciona"
**Solução**:
1. Verifique se copiou o código corretamente (6 dígitos)
2. Verifique se não passou 15 minutos
3. Solicite um novo código se expirou

### Problema: "Gateway não responde"
**Solução**:
1. Aguarde 60 segundos após iniciar
2. Verifique se aparece "UP" no Eureka
3. Tente acessar: http://localhost:8080/actuator/health

---

## Próximos Passos

Após testar tudo:
1. Se encontrar bugs, anote o erro exato
2. Verifique os logs na janela CMD correspondente
3. Teste novamente para confirmar o erro
4. Me envie os detalhes que ajudo a corrigir!

---

**Bons testes! 🚀**
