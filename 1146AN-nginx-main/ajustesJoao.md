<div align="center">

# 🎟️ Sistema JoinUp - Documentação de Correções

### Relatório Técnico de Ajustes e Melhorias

**Desenvolvedor:** João Franco
**Data:** 18 de Novembro de 2025
**Versão do Sistema:** 0.0.1-SNAPSHOT

---

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.x-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Status](https://img.shields.io/badge/Status-Operacional-success.svg)]()

</div>

---

## 📑 Índice

- [1. Visão Geral](#1-visão-geral)
  - [Problemas Resolvidos](#problemas-resolvidos)
  - [Resumo Executivo](#resumo-executivo)
- [2. Guia de Inicialização Rápida](#2-guia-de-inicialização-rápida)
  - [Pré-requisitos](#pré-requisitos)
  - [Fluxo de Inicialização Completo](#fluxo-de-inicialização-completo)
  - [Comandos Essenciais](#comandos-essenciais)
- [3. Scripts de Automação](#3-scripts-de-automação)
  - [start-all.sh](#script-1-start-allsh)
  - [stop-all.sh](#script-2-stop-allsh)
  - [check-health.sh](#script-3-check-healthsh)
- [4. Correções Técnicas Implementadas](#4-correções-técnicas-implementadas)
  - [Correção #1: Lombok e Java 21](#correção-1-incompatibilidade-lombok-com-java-21)
  - [Correção #2: Duplicação de Headers CORS](#correção-2-duplicação-de-headers-cors)
  - [Correção #3: Bloqueio de OPTIONS](#correção-3-bloqueio-de-requisições-options)
  - [Correção #4: Protocolo file://](#correção-4-protocolo-file-no-frontend)
  - [Correção #5: Scripts de Automação](#correção-5-criação-de-scripts-de-automação)
- [5. Configuração do Sistema](#5-configuração-do-sistema)
  - [CORS Gateway](#configuração-cors-do-gateway)
  - [Rotas do Gateway](#rotas-do-gateway)
  - [Autenticação e Autorização](#autenticação-e-autorização)
- [6. Verificação e Testes](#6-verificação-e-testes)
  - [Checklist de Validação](#checklist-de-validação)
  - [Como Testar o Sistema](#como-testar-o-sistema)
- [7. Troubleshooting](#7-troubleshooting)
- [8. Referências](#8-referências)
- [9. Lições Aprendidas](#9-lições-aprendidas)
- [10. Resumo de Mudanças](#10-resumo-de-mudanças)

---

## 1. Visão Geral

### Problemas Resolvidos

Este documento detalha todas as correções aplicadas ao sistema JoinUp para resolver problemas críticos de compilação, CORS e configuração do ambiente de desenvolvimento.

<table>
<tr>
<td align="center">✅</td>
<td><b>Incompatibilidade Lombok com Java 21</b><br/>Sistema não compilava devido à versão incompatível do Lombok</td>
</tr>
<tr>
<td align="center">✅</td>
<td><b>Duplicação de Headers CORS</b><br/>Navegador rejeitava requisições por duplicação de headers</td>
</tr>
<tr>
<td align="center">✅</td>
<td><b>Bloqueio de Requisições OPTIONS</b><br/>Preflight CORS falhava com 401 Unauthorized</td>
</tr>
<tr>
<td align="center">✅</td>
<td><b>Protocolo file:// no Frontend</b><br/>Frontend aberto diretamente do sistema de arquivos causava erros</td>
</tr>
<tr>
<td align="center">✅</td>
<td><b>Falta de Scripts de Automação</b><br/>Processo manual e tedioso de iniciar 5 microservices</td>
</tr>
</table>

### Resumo Executivo

O sistema JoinUp é uma plataforma de compra de ingressos construída com arquitetura de microservices usando Spring Cloud. Durante o desenvolvimento, foram identificados 5 problemas críticos que impediam a operação correta do sistema. Todas as correções foram aplicadas com sucesso e o sistema está 100% operacional.

**Resultado:** Sistema totalmente funcional com automação completa de deploy e monitoramento.

---

## 2. Guia de Inicialização Rápida

### Pré-requisitos

Antes de iniciar o sistema, certifique-se de ter instalado:

| Componente | Versão Mínima | Verificação |
|------------|---------------|-------------|
| **Java JDK** | 21 | `java -version` |
| **Maven** | 3.8+ | `mvn -version` |
| **Python** | 3.x | `python3 --version` |
| **PostgreSQL** | 13+ | `psql --version` |

### Fluxo de Inicialização Completo

Siga este passo a passo para iniciar o sistema pela primeira vez:

#### **Passo 1: Navegue até o diretório do projeto**

```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main
```

#### **Passo 2: Inicie todos os microservices**

```bash
# Primeira execução (com recompilação)
./start-all.sh --recompile

# Execuções subsequentes
./start-all.sh
```

⏱️ **Tempo estimado:** 2-3 minutos para inicialização completa

#### **Passo 3: Aguarde confirmação de inicialização**

O script mostrará o status de cada serviço:

```
✓ Eureka Server iniciado na porta 8761
✓ Auth Service iniciado na porta 8084
✓ Event Service iniciado na porta 8083
✓ Ticket Service iniciado na porta 8085
✓ Gateway Service iniciado na porta 8080
```

#### **Passo 4: Inicie o servidor HTTP do frontend**

Em um novo terminal:

```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/frontend
python3 -m http.server 3000
```

#### **Passo 5: Acesse a aplicação**

Abra seu navegador em: **http://localhost:3000**

<table>
<tr>
<th>Página</th>
<th>URL</th>
<th>Descrição</th>
</tr>
<tr>
<td>🏠 Início</td>
<td><code>http://localhost:3000/index.html</code></td>
<td>Página principal com lista de eventos</td>
</tr>
<tr>
<td>🔐 Login</td>
<td><code>http://localhost:3000/login.html</code></td>
<td>Autenticação de usuários</td>
</tr>
<tr>
<td>📝 Registro</td>
<td><code>http://localhost:3000/register.html</code></td>
<td>Cadastro de novos usuários</td>
</tr>
<tr>
<td>➕ Criar Evento</td>
<td><code>http://localhost:3000/criar-evento.html</code></td>
<td>Criação de eventos (organizers)</td>
</tr>
</table>

### Comandos Essenciais

#### Inicialização

```bash
# Iniciar sistema completo
./start-all.sh

# Iniciar com recompilação
./start-all.sh --recompile

# Iniciar frontend
cd frontend && python3 -m http.server 3000
```

#### Monitoramento

```bash
# Verificar status de todos os serviços
./check-health.sh

# Ver logs de um serviço específico
tail -f logs/gateway-service.log
tail -f logs/event-service.log

# Verificar portas em uso
netstat -tuln | grep -E '8080|8083|8084|8085|8761|3000'
```

#### Parada

```bash
# Parar todos os microservices
./stop-all.sh

# Parar frontend (Ctrl+C no terminal onde está rodando)
```

---

## 3. Scripts de Automação

Foram criados três scripts Bash para facilitar o gerenciamento do sistema.

### Script 1: `start-all.sh`

#### 📍 Localização
```
/home/jfranco/code/joinUp-teste/1146AN-nginx-main/start-all.sh
```

#### 🎯 Objetivo
Automatizar a inicialização de todos os 5 microservices na ordem correta, com verificação de saúde e logs centralizados.

#### ⚙️ Funcionalidades

- ✅ Verifica pré-requisitos (Java 17+, Maven)
- ✅ Opção de recompilação automática
- ✅ Inicia serviços na ordem de dependência
- ✅ Aguarda cada serviço estar UP antes de prosseguir
- ✅ Salva PIDs para gerenciamento posterior
- ✅ Logs centralizados no diretório `logs/`
- ✅ Mensagens coloridas e informativas

#### 📝 Ordem de Inicialização

```
1. Eureka Server (8761)   → Service Discovery
2. Auth Service (8084)     → Autenticação
3. Event Service (8083)    → Gerenciamento de Eventos
4. Ticket Service (8085)   → Sistema de Ingressos
5. Gateway Service (8080)  → API Gateway
```

#### 💻 Como Usar

```bash
# Sintaxe
./start-all.sh [--recompile]

# Exemplos
./start-all.sh              # Inicia todos os serviços
./start-all.sh --recompile  # Recompila antes de iniciar
```

#### 📊 Saída Esperada

```
========================================
   JoinUp - Iniciando Sistema
========================================

► Verificando pré-requisitos...
  ✓ Java 21 encontrado
  ✓ Maven 3.9.6 encontrado

► Iniciando Eureka Server...
  ✓ Eureka Server iniciado na porta 8761

► Iniciando Auth Service...
  ✓ Auth Service iniciado na porta 8084

...

✓ Todos os serviços foram iniciados com sucesso!
```

---

### Script 2: `stop-all.sh`

#### 📍 Localização
```
/home/jfranco/code/joinUp-teste/1146AN-nginx-main/stop-all.sh
```

#### 🎯 Objetivo
Parar todos os microservices de forma graciosa e organizada.

#### ⚙️ Funcionalidades

- ✅ Para serviços usando PIDs salvos
- ✅ Envia sinal SIGTERM (parada graciosa)
- ✅ Verifica se processos terminaram
- ✅ Força parada se necessário (SIGKILL)
- ✅ Limpa arquivo de PIDs
- ✅ Feedback visual do processo

#### 💻 Como Usar

```bash
./stop-all.sh
```

#### 📊 Saída Esperada

```
========================================
   JoinUp - Parando Sistema
========================================

► Parando serviços...
  ✓ Gateway Service parado
  ✓ Ticket Service parado
  ✓ Event Service parado
  ✓ Auth Service parado
  ✓ Eureka Server parado

✓ Todos os serviços foram parados!
```

---

### Script 3: `check-health.sh`

#### 📍 Localização
```
/home/jfranco/code/joinUp-teste/1146AN-nginx-main/check-health.sh
```

#### 🎯 Objetivo
Verificar o status detalhado de todos os serviços do sistema.

#### ⚙️ Funcionalidades

- ✅ Lista processos Java em execução
- ✅ Verifica health de cada serviço (HTTP)
- ✅ Consulta registro no Eureka
- ✅ Testa endpoints principais via Gateway
- ✅ Mostra portas em uso
- ✅ Exibe uso de memória e uptime
- ✅ Fornece dicas e comandos úteis

#### 💻 Como Usar

```bash
./check-health.sh
```

#### 📊 Saída Esperada

```
========================================
   JoinUp - Status do Sistema
========================================

► PROCESSOS EM EXECUÇÃO

PID   | Porta | Serviço
------|-------|------------------
12345 | 8761  | eureka-server
12346 | 8084  | auth-service
12347 | 8083  | event-service
12348 | 8085  | ticket-service
12349 | 8080  | gateway-service

► STATUS DOS SERVIÇOS (Health Check)

Eureka Server  : ✓ UP
Gateway        : ✓ UP
Auth Service   : ✓ UP
Event Service  : ✓ UP
Ticket Service : ✓ UP

► SERVIÇOS REGISTRADOS NO EUREKA

✓ AUTH-SERVICE (1 instância)
✓ EVENT-SERVICE (1 instância)
✓ GATEWAY-SERVICE (1 instância)
✓ TICKET-SERVICE (1 instância)

► ENDPOINTS PRINCIPAIS (via Gateway)

Listar Eventos      : ✓ Acessível (HTTP 200)
Event Service Direto: ✓ Acessível (HTTP 200)

✓ Todos os serviços estão rodando!
```

---

## 4. Correções Técnicas Implementadas

### Correção #1: Incompatibilidade Lombok com Java 21

#### 🔴 Problema Identificado

O sistema não compilava e apresentava o seguinte erro:

```
java.lang.NoSuchFieldError: Class com.sun.tools.javac.tree.JCTree$JCImport
does not have member field 'com.sun.tools.javac.tree.JCTree qualid'
```

#### 🔍 Causa Raiz

A biblioteca **Lombok versão 1.18.26** não possui suporte para **Java 21**. O Lombok precisa acessar APIs internas do compilador Java, que mudaram significativamente entre as versões do JDK. A versão 1.18.26 foi compilada para versões anteriores do Java e não reconhece as estruturas internas do Java 21.

#### ✅ Solução Implementada

Atualização do Lombok para a versão **1.18.34** em todos os microservices.

#### 📝 Arquivos Modificados

| Serviço | Arquivo | Linhas |
|---------|---------|--------|
| **Auth Service** | `pom.xml` | ~35, ~60 |
| **Event Service** | `pom.xml` | ~35, ~60 |
| **Ticket Service** | `pom.xml` | ~35, ~60 |
| **Gateway Service** | `pom.xml` | ~35, ~60 |

#### 💾 Código Modificado

```xml
<!-- ❌ ANTES (versão incompatível) -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.26</version>
    <scope>provided</scope>
</dependency>

<!-- ✅ DEPOIS (versão compatível) -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.34</version>
    <scope>provided</scope>
</dependency>
```

#### 🎯 Por Que Funcionou?

Lombok 1.18.34 foi lançado com:
- ✅ Suporte completo para Java 21
- ✅ Compatibilidade com as novas APIs internas do compilador
- ✅ Correção de bugs relacionados a records e pattern matching
- ✅ Melhorias de performance

#### 📚 Referências
- [Lombok Changelog](https://projectlombok.org/changelog)
- [Issue #3393 - Java 21 Support](https://github.com/projectlombok/lombok/issues/3393)

---

### Correção #2: Duplicação de Headers CORS

#### 🔴 Problema Identificado

O navegador rejeitava todas as requisições com o seguinte erro:

```
Access to fetch at 'http://localhost:8080/api/events' from origin 'http://localhost:3000'
has been blocked by CORS policy: The 'Access-Control-Allow-Origin' header contains
multiple values '*, *', but only one is allowed.
```

#### 🔍 Causa Raiz

**Dois pontos diferentes estavam adicionando headers CORS simultaneamente:**

<table>
<tr>
<th>Ponto de Injeção</th>
<th>Localização</th>
<th>Configuração</th>
</tr>
<tr>
<td>🔹 Gateway Service</td>
<td><code>application.yml</code></td>
<td>
<pre>
globalcors:
  corsConfigurations:
    '[/**]':
      allowedOrigins: "*"
</pre>
</td>
</tr>
<tr>
<td>🔹 Backend Services</td>
<td>Controllers Java</td>
<td>
<pre>
@CrossOrigin(origins = "*")
public class Controller { }
</pre>
</td>
</tr>
</table>

**Fluxo do Problema:**

```
Browser Request
    ↓
Gateway adiciona: Access-Control-Allow-Origin: *
    ↓
Backend Service adiciona: Access-Control-Allow-Origin: *
    ↓
Response final: Access-Control-Allow-Origin: *, *
    ↓
❌ Browser rejeita (duplicação)
```

#### ✅ Solução Implementada

**Princípio:** Apenas o Gateway deve gerenciar CORS em arquiteturas de microservices.

Remoção de todas as anotações `@CrossOrigin` dos controllers dos microservices backend.

#### 📝 Arquivos Modificados

**Event Service (3 arquivos):**

| Controller | Arquivo | Linha |
|------------|---------|-------|
| PublicEventController | `PublicEventController.java` | 19 |
| OrganizerEventController | `OrganizerEventController.java` | 21 |
| DashboardController | `DashboardController.java` | 21 |

**Ticket Service (2 arquivos):**

| Controller | Arquivo | Linha |
|------------|---------|-------|
| PurchaseController | `PurchaseController.java` | 22 |
| MetricsController | `MetricsController.java` | 20 |

#### 💾 Código Modificado

```java
// ❌ ANTES
@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")  // ← PROBLEMA: Duplica CORS
public class PublicEventController {
    // ...
}

// ✅ DEPOIS
@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
// Sem @CrossOrigin - Gateway gerencia CORS
public class PublicEventController {
    // ...
}
```

#### 🎯 Por Que Funcionou?

**Novo fluxo (correto):**

```
Browser Request
    ↓
Gateway adiciona: Access-Control-Allow-Origin: *
    ↓
Backend Service (sem CORS)
    ↓
Response final: Access-Control-Allow-Origin: *
    ↓
✅ Browser aceita (header único)
```

#### 📐 Princípio Arquitetural

<table>
<tr>
<th>Componente</th>
<th>Responsabilidade CORS</th>
<th>Motivo</th>
</tr>
<tr>
<td><b>API Gateway</b></td>
<td>✅ Gerencia CORS</td>
<td>
• Ponto único de entrada<br/>
• Cross-cutting concern<br/>
• Configuração centralizada
</td>
</tr>
<tr>
<td><b>Microservices</b></td>
<td>❌ Não gerencia CORS</td>
<td>
• Focados em lógica de negócio<br/>
• Não são acessados diretamente<br/>
• Simplifica manutenção
</td>
</tr>
</table>

---

### Correção #3: Bloqueio de Requisições OPTIONS

#### 🔴 Problema Identificado

Requisições POST/PUT/DELETE para endpoints protegidos falhavam com:

```
Access to fetch at 'http://localhost:8080/api/organizer/events' from origin
'http://localhost:3000' has been blocked by CORS policy: Response to preflight
request doesn't pass access control check: No 'Access-Control-Allow-Origin'
header is present on the requested resource.
```

**Endpoints Afetados:**
- 🚫 `/api/organizer/events` (criar eventos)
- 🚫 `/api/purchases` (comprar ingressos)
- 🚫 `/api/dashboard` (dashboard)

#### 🔍 Causa Raiz

O `AuthorizationFilter` estava bloqueando requisições **OPTIONS** com `401 Unauthorized`.

#### 📚 Entendendo CORS Preflight

Quando o navegador precisa fazer uma requisição "não simples" (POST com JSON, headers customizados, etc.), ele segue este fluxo:

```
┌─────────────────────────────────────────────────────────┐
│ Passo 1: Preflight (OPTIONS)                            │
├─────────────────────────────────────────────────────────┤
│ Browser → OPTIONS /api/organizer/events                 │
│           Origin: http://localhost:3000                  │
│           Access-Control-Request-Method: POST            │
│                                                          │
│ Server → 200 OK                                          │
│          Access-Control-Allow-Origin: *                  │
│          Access-Control-Allow-Methods: POST              │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│ Passo 2: Requisição Real (POST)                         │
├─────────────────────────────────────────────────────────┤
│ Browser → POST /api/organizer/events                    │
│           Authorization: Bearer <token>                  │
│           Content-Type: application/json                 │
│           { "eventData": "..." }                         │
│                                                          │
│ Server → 201 Created                                     │
│          { "id": "123", "name": "..." }                  │
└─────────────────────────────────────────────────────────┘
```

#### ❌ O Que Estava Acontecendo (Fluxo Incorreto)

```
Browser
    ↓ OPTIONS /api/organizer/events (SEM token JWT)
Gateway - AuthorizationFilter
    ↓ Verifica token JWT
    ↓ Token ausente
Gateway
    ↓ 401 Unauthorized
    ↓ (sem headers CORS)
Browser
    ❌ Bloqueia requisição POST real
    ❌ Usuário não consegue criar evento
```

#### ✅ Solução Implementada

Adicionar bypass para requisições OPTIONS no `AuthorizationFilter`.

#### 📝 Arquivo Modificado

```
gateway-service/src/main/java/com/example/gateway_service/
infrastructure/security/AuthorizationFilter.java
```

**Linhas modificadas:** 73-76

#### 💾 Código Adicionado

```java
@Override
public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
    ServerHttpRequest request = exchange.getRequest();
    String path = request.getPath().toString();

    // ✅ ADICIONADO - Permitir OPTIONS sem autenticação
    if ("OPTIONS".equals(request.getMethod().name())) {
        return chain.filter(exchange);  // Passa direto sem verificar JWT
    }

    // Verifica se a rota é protegida
    if (routeRole.entrySet().stream().noneMatch(entry -> path.startsWith(entry.getKey()))) {
        return chain.filter(exchange);
    }

    // Verifica autenticação JWT (apenas para métodos não-OPTIONS)
    String authHeader = request.getHeaders().getFirst("Authorization");
    if (authHeader == null || !authHeader.startsWith("Bearer ")) {
        return unauthorized(exchange);
    }

    // ... resto do código de validação JWT
}
```

#### ✅ Fluxo Correto (Após Correção)

```
Browser
    ↓ OPTIONS /api/organizer/events (sem token)
Gateway - AuthorizationFilter
    ↓ Detecta método OPTIONS
    ↓ Passa sem verificar autenticação
Gateway - CORS Filter
    ↓ Adiciona headers CORS
Gateway
    ↓ 200 OK + headers CORS
Browser
    ✅ Preflight OK
    ↓ Envia POST real (COM token JWT)
Gateway - AuthorizationFilter
    ↓ Valida token JWT
    ✅ Token válido, role ORGANIZER
Backend
    ✅ Evento criado com sucesso
```

#### 🔒 Padrão de Segurança

**Por que OPTIONS nunca deve exigir autenticação?**

<table>
<tr>
<td>1️⃣</td>
<td>São enviadas <b>automaticamente</b> pelo navegador (usuário não controla)</td>
</tr>
<tr>
<td>2️⃣</td>
<td>Não contêm <b>dados sensíveis</b> ou payload</td>
</tr>
<tr>
<td>3️⃣</td>
<td>Servem apenas para <b>verificar permissões CORS</b></td>
</tr>
<tr>
<td>4️⃣</td>
<td>A <b>requisição real</b> (POST/PUT/DELETE) ainda requer autenticação</td>
</tr>
<tr>
<td>5️⃣</td>
<td>Faz parte do <b>padrão W3C</b> de CORS</td>
</tr>
</table>

---

### Correção #4: Protocolo `file://` no Frontend

#### 🔴 Problema Identificado

Usuário abria arquivos HTML diretamente do sistema de arquivos:

```
file:///home/jfranco/code/joinUp-teste/1146AN-nginx-main/frontend/index.html
```

Isso causava múltiplos problemas:
- ❌ Origin considerado como `"null"` pelo navegador
- ❌ Erros `net::ERR_CONNECTION_REFUSED`
- ❌ CORS não funciona com origin "null"
- ❌ Restrições de segurança adicionais

#### 🔍 Causa Raiz

**Comportamento do navegador com `file://`:**

<table>
<tr>
<th>Aspecto</th>
<th>file://</th>
<th>http://</th>
</tr>
<tr>
<td>Origin</td>
<td>❌ <code>"null"</code></td>
<td>✅ <code>"http://localhost:3000"</code></td>
</tr>
<tr>
<td>CORS</td>
<td>❌ Não funciona corretamente</td>
<td>✅ Funciona normalmente</td>
</tr>
<tr>
<td>Requisições HTTP</td>
<td>❌ Bloqueadas por segurança</td>
<td>✅ Permitidas</td>
</tr>
<tr>
<td>Cookies/Storage</td>
<td>❌ Restrições severas</td>
<td>✅ Funciona normalmente</td>
</tr>
</table>

#### ✅ Solução Implementada

Criar **servidor HTTP local** para servir o frontend.

#### 💻 Como Implementar

**Opção 1: Python (Recomendado)**

```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main/frontend
python3 -m http.server 3000
```

**Opção 2: Node.js**

```bash
npx serve -p 3000
```

**Opção 3: PHP**

```bash
php -S localhost:3000
```

#### 🌐 URLs Corretas

| Antes (❌ Incorreto) | Depois (✅ Correto) |
|---------------------|-------------------|
| `file:///home/.../index.html` | `http://localhost:3000/index.html` |
| `file:///home/.../login.html` | `http://localhost:3000/login.html` |
| `file:///home/.../criar-evento.html` | `http://localhost:3000/criar-evento.html` |

#### 🎯 Por Que Funcionou?

```
✅ Origin válido: "http://localhost:3000"
    ↓
✅ Navegador aplica regras CORS corretamente
    ↓
✅ Gateway reconhece origin e adiciona headers apropriados
    ↓
✅ Requisições funcionam normalmente
```

---

### Correção #5: Criação de Scripts de Automação

#### 🔴 Problema Identificado

O processo manual de iniciar 5 microservices apresentava os seguintes problemas:

<table>
<tr>
<td>❌</td>
<td><b>Tedioso</b> - Necessário abrir 5 terminais diferentes</td>
</tr>
<tr>
<td>❌</td>
<td><b>Propenso a erros</b> - Ordem incorreta causa falhas</td>
</tr>
<tr>
<td>❌</td>
<td><b>Difícil de debugar</b> - Logs espalhados em múltiplos terminais</td>
</tr>
<tr>
<td>❌</td>
<td><b>Sem verificação</b> - Não sabia se serviço iniciou corretamente</td>
</tr>
<tr>
<td>❌</td>
<td><b>Sem automação</b> - Toda vez o mesmo processo manual</td>
</tr>
</table>

#### ✅ Solução Implementada

Criação de 3 scripts Bash automatizados (veja [Seção 3](#3-scripts-de-automação) para detalhes completos):

1. ✅ **start-all.sh** - Inicia todos os serviços
2. ✅ **stop-all.sh** - Para todos os serviços
3. ✅ **check-health.sh** - Verifica status do sistema

---

## 5. Configuração do Sistema

### Configuração CORS do Gateway

#### 📁 Arquivo
```
gateway-service/src/main/resources/application.yml
```

#### ⚙️ Configuração Aplicada

```yaml
spring:
  cloud:
    gateway:
      globalcors:
        corsConfigurations:
          '[/**]':              # Aplica a todas as rotas
            allowedOrigins: "*"  # Aceita qualquer origem
            allowedMethods: "*"  # Aceita todos os métodos HTTP
            allowedHeaders: "*"  # Aceita todos os headers
            maxAge: 3600         # Cache preflight por 1 hora
```

#### 📋 Significado dos Parâmetros

| Parâmetro | Valor | Significado |
|-----------|-------|-------------|
| `allowedOrigins` | `"*"` | Aceita requisições de qualquer domínio |
| `allowedMethods` | `"*"` | Permite GET, POST, PUT, DELETE, OPTIONS, PATCH |
| `allowedHeaders` | `"*"` | Permite qualquer header (Authorization, Content-Type, etc.) |
| `maxAge` | `3600` | Navegador cacheia resposta preflight por 1 hora |

> ⚠️ **Produção:** Substitua `"*"` por domínios específicos para maior segurança.

---

### Rotas do Gateway

#### 🛣️ Mapeamento Completo

```yaml
spring:
  cloud:
    gateway:
      routes:
        # ─────────────────────────────────────────────
        # 🔐 AUTH SERVICE - Autenticação
        # ─────────────────────────────────────────────
        - id: auth-register
          uri: lb://AUTH-SERVICE
          predicates:
            - Path=/api/auth/register
          filters:
            - RewritePath=/api/auth/register, /users

        - id: auth-login
          uri: lb://AUTH-SERVICE
          predicates:
            - Path=/api/auth/login
          filters:
            - RewritePath=/api/auth/login, /auth/login/password

        - id: auth-password-reset-request
          uri: lb://AUTH-SERVICE
          predicates:
            - Path=/api/auth/password/reset/request
          filters:
            - RewritePath=/api/auth/password/reset/request, /auth/password/reset/request

        - id: auth-password-reset-confirm
          uri: lb://AUTH-SERVICE
          predicates:
            - Path=/api/auth/password/reset/confirm
          filters:
            - RewritePath=/api/auth/password/reset/confirm, /auth/password/reset/confirm

        # ─────────────────────────────────────────────
        # 🎫 EVENT SERVICE - Eventos
        # ─────────────────────────────────────────────
        - id: event-service
          uri: lb://EVENT-SERVICE
          predicates:
            - Path=/api/events/**, /api/organizer/**, /api/dashboard/**

        # ─────────────────────────────────────────────
        # 🎟️ TICKET SERVICE - Ingressos
        # ─────────────────────────────────────────────
        - id: ticket-service
          uri: lb://TICKET-SERVICE
          predicates:
            - Path=/api/tickets/**
```

#### 📊 Tabela de Rotas

| Rota Externa | Serviço | Rota Interna | Descrição |
|-------------|---------|--------------|-----------|
| `POST /api/auth/register` | Auth | `/users` | Cadastro de usuário |
| `POST /api/auth/login` | Auth | `/auth/login/password` | Login |
| `POST /api/auth/password/reset/request` | Auth | `/auth/password/reset/request` | Solicitar reset |
| `POST /api/auth/password/reset/confirm` | Auth | `/auth/password/reset/confirm` | Confirmar reset |
| `GET /api/events` | Event | `/api/events` | Listar eventos |
| `GET /api/events/{id}` | Event | `/api/events/{id}` | Detalhes do evento |
| `POST /api/organizer/events` | Event | `/api/organizer/events` | Criar evento |
| `GET /api/dashboard/**` | Event | `/api/dashboard/**` | Dashboard |
| `POST /api/tickets/**` | Ticket | `/api/tickets/**` | Operações de tickets |

---

### Autenticação e Autorização

#### 🔐 Sistema de Roles

O sistema utiliza **JWT (JSON Web Tokens)** para autenticação e **roles** para autorização.

#### 👥 Roles Disponíveis

<table>
<tr>
<th>Role</th>
<th>Descrição</th>
<th>Permissões</th>
</tr>
<tr>
<td><code>USER</code></td>
<td>Usuário comum</td>
<td>
• Visualizar eventos<br/>
• Comprar ingressos<br/>
• Ver próprias compras
</td>
</tr>
<tr>
<td><code>ORGANIZER</code></td>
<td>Organizador de eventos</td>
<td>
• Tudo que USER pode<br/>
• Criar eventos<br/>
• Ver dashboard<br/>
• Ver métricas de vendas
</td>
</tr>
<tr>
<td><code>ADMIN</code></td>
<td>Administrador</td>
<td>
• Acesso total ao sistema
</td>
</tr>
</table>

#### 🛡️ Rotas Protegidas

**Mapeamento no `AuthorizationFilter`:**

```java
private static final Map<String, RoleType> routeRole = Map.of(
    "/api/tickets/purchase", RoleType.USER,      // Comprar ingresso
    "/api/purchases",        RoleType.USER,      // Ver compras
    "/api/organizer/events", RoleType.ORGANIZER, // Criar evento
    "/api/dashboard",        RoleType.ORGANIZER, // Dashboard
    "/api/admin",            RoleType.ADMIN       // Admin
);
```

#### 🌍 Rotas Públicas (Sem Autenticação)

- ✅ `GET /api/events` - Listar eventos
- ✅ `GET /api/events/{id}` - Detalhes do evento
- ✅ `GET /api/events/search` - Buscar eventos
- ✅ `POST /api/auth/register` - Cadastro
- ✅ `POST /api/auth/login` - Login
- ✅ `OPTIONS /**` - Preflight CORS (qualquer rota)

#### 🔑 Estrutura do JWT

```json
{
  "sub": "user@example.com",
  "userId": "123e4567-e89b-12d3-a456-426614174000",
  "role": "ORGANIZER",
  "type": "access",
  "iat": 1700000000,
  "exp": 1700086400
}
```

---

## 6. Verificação e Testes

### Checklist de Validação

Use este checklist para verificar se todas as correções foram aplicadas corretamente:

#### ✅ Compilação

- [ ] Todos os 5 serviços compilam sem erros
- [ ] Nenhum warning relacionado a Lombok
- [ ] Build Maven completo com sucesso

```bash
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main
./start-all.sh --recompile
```

#### ✅ Inicialização

- [ ] Eureka Server iniciou na porta 8761
- [ ] Auth Service iniciou na porta 8084
- [ ] Event Service iniciou na porta 8083
- [ ] Ticket Service iniciou na porta 8085
- [ ] Gateway Service iniciou na porta 8080

```bash
./check-health.sh
```

#### ✅ Service Discovery

- [ ] Todos os 4 serviços registrados no Eureka
- [ ] Status de todos é "UP"
- [ ] Acesso ao Eureka Dashboard: http://localhost:8761

```bash
curl http://localhost:8761/eureka/apps | grep -o '<status>[^<]*</status>'
```

#### ✅ Frontend

- [ ] Servidor HTTP rodando na porta 3000
- [ ] Página inicial acessível: http://localhost:3000
- [ ] Página de login acessível: http://localhost:3000/login.html

```bash
curl -I http://localhost:3000/index.html
```

#### ✅ CORS

- [ ] Listar eventos funciona sem erro de CORS
- [ ] Login funciona sem erro de CORS
- [ ] Criar evento funciona sem erro de CORS (após login)

```bash
# Testar CORS
curl -H "Origin: http://localhost:3000" \
     -H "Access-Control-Request-Method: GET" \
     -X OPTIONS http://localhost:8080/api/events -v
```

#### ✅ Funcionalidades

- [ ] Fazer login com sucesso
- [ ] Organizador pode criar eventos
- [ ] Usuário pode comprar ingressos
- [ ] Dashboard do organizador funcional

---

### Como Testar o Sistema

#### 🧪 Teste 1: Compilação e Inicialização

```bash
# Passo 1: Limpar e recompilar tudo
cd /home/jfranco/code/joinUp-teste/1146AN-nginx-main
./start-all.sh --recompile

# Passo 2: Aguardar todos os serviços iniciarem (2-3 minutos)
# Passo 3: Verificar status
./check-health.sh

# Resultado Esperado:
# ✓ Todos os 5 serviços com status UP
```

#### 🧪 Teste 2: Registro e Login

```bash
# Iniciar frontend
cd frontend
python3 -m http.server 3000
```

**No navegador:**

1. Acesse: http://localhost:3000/register.html
2. Preencha o formulário de registro
3. Role: selecione "ORGANIZER"
4. Clique em "Registrar"
5. Acesse: http://localhost:3000/login.html
6. Faça login com as credenciais criadas

**Resultado Esperado:**
- ✅ Registro bem-sucedido
- ✅ Login bem-sucedido
- ✅ Token JWT salvo no localStorage
- ✅ Redirecionamento para página principal

#### 🧪 Teste 3: CORS em Endpoints Públicos

```bash
# Testar GET /api/events
curl -H "Origin: http://localhost:3000" \
     http://localhost:8080/api/events \
     -v 2>&1 | grep "Access-Control-Allow-Origin"

# Resultado Esperado:
# Access-Control-Allow-Origin: *
```

#### 🧪 Teste 4: CORS Preflight em Endpoints Protegidos

```bash
# Testar OPTIONS /api/organizer/events
curl -X OPTIONS \
     -H "Origin: http://localhost:3000" \
     -H "Access-Control-Request-Method: POST" \
     -H "Access-Control-Request-Headers: content-type,authorization" \
     http://localhost:8080/api/organizer/events \
     -v

# Resultado Esperado:
# HTTP/1.1 200 OK
# Access-Control-Allow-Origin: *
# Access-Control-Allow-Methods: POST
# Access-Control-Allow-Headers: content-type,authorization
```

#### 🧪 Teste 5: Criar Evento (Role ORGANIZER)

**No navegador (após login como ORGANIZER):**

1. Acesse: http://localhost:3000/criar-evento.html
2. Preencha o formulário:
   - Nome: "Teste de Evento"
   - Data: (data futura)
   - Local: "São Paulo"
   - Descrição: "Evento de teste"
   - Preço: 100.00
   - Quantidade: 50
3. Clique em "Criar Evento"

**Resultado Esperado:**
- ✅ Evento criado com sucesso
- ✅ Nenhum erro de CORS no console
- ✅ Mensagem de confirmação exibida

#### 🧪 Teste 6: Dashboard do Organizador

**No navegador (após login como ORGANIZER):**

1. Acesse: http://localhost:3000/dashboard.html
2. Verifique se os eventos criados aparecem
3. Verifique métricas (tickets vendidos, receita, etc.)

**Resultado Esperado:**
- ✅ Dashboard carrega corretamente
- ✅ Eventos listados
- ✅ Métricas exibidas

---

## 7. Troubleshooting

### ❌ Problema: Gateway não inicia

#### Sintomas
```
ERROR: Address already in use
Port 8080 is already in use
```

#### Diagnóstico

```bash
# Verificar se porta 8080 está ocupada
netstat -tuln | grep 8080

# Ver qual processo está usando
lsof -i :8080
```

#### Solução

```bash
# Opção 1: Parar processo existente
pkill -f gateway-service

# Opção 2: Se necessário, matar pelo PID
kill -9 <PID>

# Limpar target e reiniciar
cd gateway-service
rm -rf target/
mvn clean package -DskipTests
cd ..
./start-all.sh
```

---

### ❌ Problema: CORS ainda dando erro

#### Sintomas
```
Access-Control-Allow-Origin header contains multiple values
```

#### Diagnóstico

```bash
# Verificar se controllers ainda têm @CrossOrigin
grep -r "@CrossOrigin" event-service/src/
grep -r "@CrossOrigin" ticket-service/src/

# Verificar headers retornados
curl -v http://localhost:8080/api/events 2>&1 | grep "Access-Control"
```

#### Solução

```bash
# Se encontrar @CrossOrigin, remover manualmente e recompilar
cd event-service
mvn clean package -DskipTests

cd ../ticket-service
mvn clean package -DskipTests

# Reiniciar serviços
cd ..
./stop-all.sh
./start-all.sh
```

---

### ❌ Problema: Frontend não conecta no Gateway

#### Sintomas
```
GET http://localhost:8080/api/events net::ERR_CONNECTION_REFUSED
```

#### Diagnóstico

```bash
# Verificar URL do navegador
# URL errada:  file:///home/.../frontend/login.html
# URL correta: http://localhost:3000/login.html

# Verificar se gateway está rodando
curl http://localhost:8080/api/events
```

#### Solução

```bash
# Iniciar servidor HTTP para o frontend
cd frontend
python3 -m http.server 3000

# No navegador, acessar:
# http://localhost:3000/login.html
```

---

### ❌ Problema: Serviço não registra no Eureka

#### Sintomas
```
Service not found in Eureka
No instances available for AUTH-SERVICE
```

#### Diagnóstico

```bash
# Verificar Eureka Dashboard
firefox http://localhost:8761

# Ver logs do serviço
tail -f logs/auth-service.log | grep -i eureka
```

#### Solução

```bash
# Reiniciar o serviço específico
pkill -f auth-service
cd auth-service
mvn spring-boot:run > ../logs/auth-service.log 2>&1 &

# Aguardar 30 segundos e verificar Eureka novamente
sleep 30
curl http://localhost:8761/eureka/apps | grep AUTH-SERVICE
```

---

### ❌ Problema: Erro de Lombok em tempo de compilação

#### Sintomas
```
cannot find symbol: method builder()
Lombok annotations not working
```

#### Solução

```bash
# Verificar versão do Lombok em pom.xml
grep -A 3 "lombok" */pom.xml

# Deve ser 1.18.34, se não for:
# 1. Editar pom.xml
# 2. Atualizar para 1.18.34
# 3. Recompilar

mvn clean package -DskipTests
```

---

### ❌ Problema: Erro 401 em requisições autenticadas

#### Sintomas
```
HTTP/1.1 401 Unauthorized
JWT token validation failed
```

#### Diagnóstico

```bash
# Verificar se token está sendo enviado
# No navegador, abrir DevTools → Network
# Verificar header Authorization nas requisições
```

#### Solução

```
1. Fazer logout e login novamente
2. Verificar se token está no localStorage
3. Verificar se token não expirou (validade: 24h)
4. Verificar se secret do JWT é o mesmo em todos os serviços
```

---

## 8. Referências

### 📚 Documentação Oficial

#### CORS
- [MDN Web Docs - CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
- [W3C CORS Specification](https://www.w3.org/TR/cors/)
- [Spring Cloud Gateway - CORS Configuration](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#cors-configuration)

#### Spring Cloud Gateway
- [Spring Cloud Gateway Reference](https://spring.io/projects/spring-cloud-gateway)
- [Gateway Filters](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gatewayfilter-factories)
- [Route Predicates](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gateway-request-predicates-factories)

#### Lombok
- [Project Lombok](https://projectlombok.org/)
- [Lombok Changelog](https://projectlombok.org/changelog)
- [Lombok Java 21 Support - GitHub Issue #3393](https://github.com/projectlombok/lombok/issues/3393)

#### Spring Boot
- [Spring Boot 3.5.x Documentation](https://docs.spring.io/spring-boot/docs/3.5.x/reference/html/)
- [Spring Boot Microservices](https://spring.io/microservices)

#### Eureka
- [Netflix Eureka](https://github.com/Netflix/eureka)
- [Spring Cloud Netflix](https://spring.io/projects/spring-cloud-netflix)

---

## 9. Lições Aprendidas

### 💡 1. CORS em Arquitetura de Microservices

#### Princípio
> Apenas o API Gateway deve gerenciar CORS em uma arquitetura de microservices.

#### Justificativa

<table>
<tr>
<th>Aspecto</th>
<th>Gateway Gerencia CORS</th>
<th>Microservices Gerenciam CORS</th>
</tr>
<tr>
<td><b>Configuração</b></td>
<td>✅ Centralizada em um só lugar</td>
<td>❌ Duplicada em N serviços</td>
</tr>
<tr>
<td><b>Manutenção</b></td>
<td>✅ Fácil de alterar</td>
<td>❌ Alterar em todos os serviços</td>
</tr>
<tr>
<td><b>Duplicação</b></td>
<td>✅ Impossível</td>
<td>❌ Muito provável</td>
</tr>
<tr>
<td><b>Performance</b></td>
<td>✅ Headers adicionados uma vez</td>
<td>❌ Overhead em cada serviço</td>
</tr>
</table>

#### Implementação
- ✅ CORS no `application.yml` do Gateway
- ❌ Sem `@CrossOrigin` nos controllers
- ✅ Microservices focados em lógica de negócio

---

### 💡 2. Preflight Requests Devem Ser Públicas

#### Princípio
> OPTIONS requests nunca devem exigir autenticação.

#### Justificativa

1. **Enviadas automaticamente** - O navegador envia, não o desenvolvedor
2. **Sem dados sensíveis** - Não contêm payload ou informações críticas
3. **Parte do protocolo** - Faz parte do padrão CORS da W3C
4. **Requisição real autenticada** - A requisição POST/PUT/DELETE ainda requer JWT

#### Implementação
```java
if ("OPTIONS".equals(request.getMethod().name())) {
    return chain.filter(exchange); // Bypass autenticação
}
```

---

### 💡 3. Desenvolvimento Frontend Requer HTTP

#### Princípio
> Nunca desenvolver com `file://`, sempre usar servidor HTTP local.

#### Justificativa

<table>
<tr>
<th>Recurso</th>
<th>file://</th>
<th>http://localhost</th>
</tr>
<tr>
<td><b>Origin</b></td>
<td>❌ "null"</td>
<td>✅ "http://localhost:3000"</td>
</tr>
<tr>
<td><b>CORS</b></td>
<td>❌ Não funciona</td>
<td>✅ Funciona</td>
</tr>
<tr>
<td><b>Fetch API</b></td>
<td>❌ Bloqueado</td>
<td>✅ Permitido</td>
</tr>
<tr>
<td><b>LocalStorage</b></td>
<td>❌ Restrições</td>
<td>✅ Normal</td>
</tr>
<tr>
<td><b>Cookies</b></td>
<td>❌ Não funciona</td>
<td>✅ Funciona</td>
</tr>
</table>

#### Implementação
```bash
# Sempre usar
python3 -m http.server 3000

# Nunca usar
firefox /caminho/para/index.html
```

---

### 💡 4. Compatibilidade de Versões é Crítica

#### Princípio
> Manter dependências atualizadas conforme a versão do Java.

#### Justificativa

- **APIs internas mudam** - JDK altera estruturas internas entre versões
- **Lombok depende disso** - Precisa acessar compilador Java
- **Quebra silenciosa** - Código antigo pode não compilar com Java novo

#### Checklist de Atualização Java

```
□ Verificar changelog do Lombok
□ Atualizar Lombok para versão compatível
□ Atualizar Spring Boot se necessário
□ Executar mvn clean package
□ Testar compilação de todos os módulos
□ Verificar warnings de deprecated
```

---

## 10. Resumo de Mudanças

### 📊 Tabela Completa de Modificações

| # | Componente | Arquivo | Mudança | Motivo | Status |
|---|------------|---------|---------|--------|--------|
| 1 | **Auth Service** | `pom.xml` | Lombok `1.18.26` → `1.18.34` | Suporte Java 21 | ✅ |
| 2 | **Event Service** | `pom.xml` | Lombok `1.18.26` → `1.18.34` | Suporte Java 21 | ✅ |
| 3 | **Ticket Service** | `pom.xml` | Lombok `1.18.26` → `1.18.34` | Suporte Java 21 | ✅ |
| 4 | **Gateway Service** | `pom.xml` | Lombok `1.18.26` → `1.18.34` | Suporte Java 21 | ✅ |
| 5 | **Event Service** | `PublicEventController.java` | Removido `@CrossOrigin` | Evitar duplicação CORS | ✅ |
| 6 | **Event Service** | `OrganizerEventController.java` | Removido `@CrossOrigin` | Evitar duplicação CORS | ✅ |
| 7 | **Event Service** | `DashboardController.java` | Removido `@CrossOrigin` | Evitar duplicação CORS | ✅ |
| 8 | **Ticket Service** | `PurchaseController.java` | Removido `@CrossOrigin` | Evitar duplicação CORS | ✅ |
| 9 | **Ticket Service** | `MetricsController.java` | Removido `@CrossOrigin` | Evitar duplicação CORS | ✅ |
| 10 | **Gateway Service** | `AuthorizationFilter.java` | Bypass OPTIONS | Permitir CORS preflight | ✅ |
| 11 | **Automação** | `start-all.sh` | Script criado | Inicialização automática | ✅ |
| 12 | **Automação** | `stop-all.sh` | Script criado | Parada automática | ✅ |
| 13 | **Automação** | `check-health.sh` | Script criado | Monitoramento | ✅ |

### 📈 Estatísticas

<table>
<tr>
<td><b>Total de Arquivos Modificados</b></td>
<td>13</td>
</tr>
<tr>
<td><b>Total de Linhas Alteradas</b></td>
<td>~50</td>
</tr>
<tr>
<td><b>Scripts Criados</b></td>
<td>3</td>
</tr>
<tr>
<td><b>Problemas Resolvidos</b></td>
<td>5</td>
</tr>
<tr>
<td><b>Tempo de Correção</b></td>
<td>~3 horas</td>
</tr>
</table>

---

<div align="center">

## 🎉 Sistema 100% Operacional

**Todas as correções foram aplicadas com sucesso!**

O sistema JoinUp está pronto para uso em ambiente de desenvolvimento.

---

### 📞 Suporte

Para dúvidas ou problemas, consulte a seção [Troubleshooting](#7-troubleshooting).

---

**Desenvolvido com ❤️ usando Spring Boot, Spring Cloud e Java 21**

📅 **Última atualização:** 18 de Novembro de 2025
👤 **Desenvolvedor:** João Franco
🤖 **Assistência técnica:** Claude Code Assistant

</div>
