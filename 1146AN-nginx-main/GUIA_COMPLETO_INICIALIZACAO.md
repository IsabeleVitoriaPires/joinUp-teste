# Guia Completo de Inicialização - JoinUp

## PASSO 1: PARAR TUDO QUE ESTÁ RODANDO

### Windows - Matar processos Java
1. Abra o CMD como Administrador
2. Execute:
```cmd
taskkill /F /IM java.exe /T
```

Ou use o script:
```cmd
PARAR_TODOS_SERVICOS.bat
```

---

## PASSO 2: VERIFICAR SE OS JARS FORAM COMPILADOS

Abra o CMD e execute:

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main

dir service-discovery\target\*.jar
dir auth-service\target\*.jar
dir event-service\target\*.jar
dir ticket-service\target\*.jar
dir gateway-service\target\*.jar
```

**VOCÊ DEVE VER 5 ARQUIVOS .JAR**

Se não aparecerem, compile primeiro:
```cmd
COMPILAR.bat
```

---

## PASSO 3: INICIAR OS SERVIÇOS NA ORDEM CORRETA

### 3.1 Service Discovery (PRIMEIRO - OBRIGATÓRIO)

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main\service-discovery
java -jar target\service-discovery-0.0.1-SNAPSHOT.jar
```

**AGUARDE até ver:**
```
Started Eureka Server
```

**DEIXE ESTA JANELA ABERTA!**

### 3.2 Abrir nova janela CMD e iniciar Auth Service

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main\auth-service
java -jar target\authservice-0.0.1-SNAPSHOT.jar
```

**AGUARDE até ver:**
```
Started AuthserviceApplication in X.XXX seconds
```

### 3.3 Abrir nova janela CMD e iniciar Event Service

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main\event-service
java -jar target\event-service-0.0.1-SNAPSHOT.jar
```

**AGUARDE até ver:**
```
Started EventServiceApplication in X.XXX seconds
```

### 3.4 Abrir nova janela CMD e iniciar Ticket Service

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main\ticket-service
java -jar target\ticket-service-0.0.1-SNAPSHOT.jar
```

**AGUARDE até ver:**
```
Started TicketServiceApplication in X.XXX seconds
```

### 3.5 Abrir nova janela CMD e iniciar Gateway

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main\gateway-service
java -jar target\gateway-service-0.0.1-SNAPSHOT.jar
```

**AGUARDE até ver:**
```
Started GatewayServiceApplication in X.XXX seconds
```

---

## PASSO 4: VERIFICAR SE TUDO ESTÁ FUNCIONANDO

### 4.1 Verificar Eureka

Abra o navegador: **http://localhost:8761**

Você DEVE ver:

```
Instances currently registered with Eureka

AUTH-SERVICE        UP (1)
EVENT-SERVICE       UP (1)
GATEWAY-SERVICE     UP (1)
TICKET-SERVICE      UP (1)
```

**SE ALGUM NÃO APARECER OU ESTIVER "DOWN":**
- Vá na janela CMD daquele serviço
- Veja se há ERROS em vermelho
- Copie o erro e me envie

### 4.2 Testar Gateway

Abra o CMD e execute:

```cmd
curl http://localhost:8080/actuator/health
```

**DEVE RETORNAR:**
```json
{"status":"UP"}
```

**SE DER ERRO "Connection refused":**
- O Gateway não está rodando
- Vá na janela do Gateway e veja os erros

### 4.3 Testar Auth Service via Gateway

```cmd
curl http://localhost:8080/api/auth/register -H "Content-Type: application/json" -d "{\"firstName\":\"Teste\",\"lastName\":\"Silva\",\"email\":\"teste@teste.com\",\"password\":\"senha12345\",\"role\":\"USER\"}"
```

**DEVE RETORNAR os dados do usuário criado**

---

## PASSO 5: INICIAR O FRONTEND

### 5.1 Abrir nova janela CMD

```cmd
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main\frontend
python -m http.server 3000
```

**DEIXE ESTA JANELA ABERTA!**

### 5.2 Acessar no navegador

**http://localhost:3000/login.html**

---

## PASSO 6: TESTAR CADASTRO E LOGIN

### 6.1 Cadastrar Organizador

1. Clique em "Cadastre-se"
2. Preencha:
   - Primeiro Nome: João
   - Sobrenome: Silva
   - Email: joao@org.com
   - Senha: senha12345
   - Tipo: Organizador

3. Clique em "Cadastrar"

**Abra o Console do Navegador (F12) e veja se há erros!**

### 6.2 Fazer Login

1. Email: joao@org.com
2. Senha: senha12345
3. Clique em "Entrar"

**Você deve ser redirecionado para index.html**

---

## PASSO 7: CRIAR EVENTO

1. Clique em "Criar Evento"
2. Preencha todos os campos
3. Clique em "Criar Evento"

**Abra F12 (Console) e veja:**
- Tab "Network" → Veja se a requisição foi feita
- Status Code: Deve ser 200 ou 201
- Se der erro, copie a mensagem

---

## CHECKLIST DE VERIFICAÇÃO

Marque conforme verifica:

**Serviços Backend:**
- [ ] Eureka (8761) - RODANDO
- [ ] Auth Service (8084) - RODANDO e REGISTRADO no Eureka
- [ ] Event Service (8083) - RODANDO e REGISTRADO no Eureka
- [ ] Ticket Service (8085) - RODANDO e REGISTRADO no Eureka
- [ ] Gateway (8080) - RODANDO e REGISTRADO no Eureka

**Frontend:**
- [ ] Servidor HTTP (3000) - RODANDO
- [ ] Acessa http://localhost:3000/login.html - CARREGA

**Testes:**
- [ ] Cadastro funciona
- [ ] Login funciona
- [ ] Criar evento funciona (ORGANIZADOR)
- [ ] Ver eventos funciona
- [ ] Comprar ingresso funciona (USER)

---

## SE ALGUM SERVIÇO NÃO SUBIR

### Erro comum: "Port already in use"

Significa que a porta já está sendo usada. Mate o processo:

```cmd
# Ver quem está usando a porta 8080 (por exemplo)
netstat -ano | findstr :8080

# Matar o processo (substitua PID pelo número que aparecer)
taskkill /F /PID [PID]
```

### Erro comum: "Connection refused to Eureka"

O Service Discovery não está rodando. Inicie ele PRIMEIRO!

### Erro comum: "ClassNotFoundException" ou "NoClassDefFoundError"

O JAR não foi compilado corretamente. Recompile:

```cmd
cd [pasta-do-servico]
mvnw.cmd clean package -DskipTests
```

---

## LOGS IMPORTANTES

Se der erro, procure por estas mensagens nas janelas CMD:

❌ **ERROS:**
```
ERROR
Exception
Failed to
Could not
Connection refused
```

✅ **SUCESSO:**
```
Started [NomeDoServico]Application
Tomcat started on port(s): XXXX
Registered instance
```

---

## RESUMO DOS COMANDOS

```cmd
# 1. Parar tudo
taskkill /F /IM java.exe /T

# 2. Compilar (se necessário)
cd C:\Users\isabe\sistema_eventos\1146AN-nginx-main
COMPILAR.bat

# 3. Iniciar backend (5 janelas CMD separadas)
# Janela 1
cd service-discovery
java -jar target\service-discovery-0.0.1-SNAPSHOT.jar

# Janela 2
cd auth-service
java -jar target\authservice-0.0.1-SNAPSHOT.jar

# Janela 3
cd event-service
java -jar target\event-service-0.0.1-SNAPSHOT.jar

# Janela 4
cd ticket-service
java -jar target\ticket-service-0.0.1-SNAPSHOT.jar

# Janela 5
cd gateway-service
java -jar target\gateway-service-0.0.1-SNAPSHOT.jar

# 4. Iniciar frontend (nova janela)
cd frontend
python -m http.server 3000

# 5. Acessar
http://localhost:3000/login.html
```

---

**Siga este guia passo a passo e me diga em qual passo você teve problema!**
