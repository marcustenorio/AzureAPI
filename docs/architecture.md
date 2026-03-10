# Arquitetura da Solução

## 1. Objetivo

Esta proposta apresenta uma arquitetura segura e simples para expor uma aplicação web e uma API interna no Azure, mantendo separação entre camadas, proteção de borda, acesso seguro a serviços de backend e uma abordagem coerente de alta disponibilidade.

A ideia aqui foi criar uma solução de arquitetura clara, justificável e alinhada com boas práticas de cloud.

---

## 2. Visão Geral da Solução

A solução proposta é composta pelos seguintes blocos:

- **Azure Front Door + WAF** como ponto de entrada público
- **Azure App Service (Web)** para a camada web
- **Azure App Service for Containers (API)** para a camada da API
- **Azure Storage Account** para armazenamento
- **Managed Identity** para autenticação da API no Storage
- **VNet com duas sub-redes** para separação lógica
- **NSG** para controle de tráfego L3/L4
- **Observabilidade** com Azure Monitor, Application Insights e NSG Flow Logs

A arquitetura foi desenhada para garantir:

- exposição controlada da aplicação
- proteção do backend
- separação de responsabilidades
- menor superfície de ataque
- melhor previsibilidade operacional

---

## 3. Escolhas de Rede

### 3.1 VNet com duas sub-redes

A solução usa uma **VNet** com duas sub-redes:

- **Web Subnet**
- **App Subnet**

Essa separação foi escolhida para evitar uma topologia “achatada”, em que tudo fica no mesmo segmento de rede.

Os benefícios dessa divisão são:

- segmentação lógica entre camadas
- aplicação mais clara de políticas de segurança
- redução de risco de movimentação lateral
- organização melhor do ambiente

### 3.2 NSG

O **Network Security Group (NSG)** foi escolhido como camada principal de controle de tráfego **L3/L4**.

Ele é usado para:

- negar tráfego público desnecessário
- permitir apenas os fluxos esperados
- bloquear portas administrativas expostas
- restringir tráfego lateral entre camadas

---

## 4. Segurança de Borda: Private Endpoint vs. Público + WAF

Esse é um dos pontos centrais da arquitetura.

A resposta correta aqui não é tratar as duas abordagens como concorrentes, mas como **controles aplicados em componentes diferentes**.

### 4.1 Público + WAF

A camada web da aplicação precisa ser acessada externamente.  
Por isso, a entrada pública é feita de forma controlada por **Azure Front Door + WAF**.

Essa escolha faz sentido porque o WAF atua em **camada 7 (L7)**, protegendo tráfego HTTP/HTTPS com recursos como:

- inspeção de requisições
- mitigação de ataques OWASP
- bloqueio de payloads maliciosos
- filtragem de padrões anômalos
- proteção da borda pública

Ou seja, o WAF protege o que **precisa ser público**.

### 4.2 Private Endpoint

Já o **Storage Account** não precisa ser exposto à internet.

Por isso, a escolha correta para ele é **Private Endpoint**, porque isso permite:

- reduzir a superfície de ataque
- manter o acesso dentro do contexto privado da rede
- evitar exposição pública desnecessária
- melhorar a postura de segurança do backend

Ou seja, o Storage não deve ser público “protegido por WAF”, porque o papel dele não é ser ponto de entrada da aplicação.

### 4.3 Conclusão dessa decisão

Neste cenário, a combinação correta é:

- **público + WAF** para a borda da aplicação
- **Private Endpoint** para serviços internos, como Storage

Essa abordagem separa bem:

- o que precisa de **exposição controlada**
- do que precisa de **acesso privado**

---

## 5. Regras Essenciais de Segurança (L3/L4 e L7)

### 5.1 Regras L3/L4

Na camada de rede, as regras essenciais são:

1. negar inbound público direto para a camada da API
2. permitir somente **Web -> API em 443**
3. permitir saída HTTPS controlada
4. bloquear SSH/RDP vindos da internet
5. restringir movimento lateral desnecessário

Essas regras estão representadas no arquivo `security/nsg-rules.yaml`.

### 5.2 Regras L7

Na camada de borda, o WAF deve tratar regras como:

- proteção contra OWASP Top 10
- inspeção de tráfego HTTP/HTTPS
- bloqueio de payload malicioso
- controle de métodos indevidos
- mitigação de padrões anômalos

Resumo simples:

- **L3/L4** controla rede, caminho, protocolo e porta
- **L7** controla comportamento da aplicação

---

## 6. Identidade e Acesso

O acesso ao Storage foi modelado com **Managed Identity**.

Essa escolha elimina a necessidade de:

- connection strings em código
- secrets armazenados
- credenciais fixas em pipeline

Fluxo de autenticação:

**API (App Service) → Managed Identity → Azure RBAC → Storage Account**

Essa abordagem é mais segura e mais aderente às boas práticas modernas do Azure.

---

## 7. Alta Disponibilidade (99,9%)

Como o requisito pede uma abordagem conceitual para **99,9%**, a proposta considera os seguintes pontos:

### 7.1 Health Probes

A API expõe endpoints como:

- `/health`
- `/ready`

Esses endpoints ajudam a borda e o balanceamento a diferenciar serviço ativo de serviço saudável.

### 7.2 Escalabilidade

A camada da aplicação pode escalar com base em métricas como:

- CPU
- memória
- taxa de requisição
- latência

### 7.3 Redundância

Quando aplicável, a solução pode ser distribuída entre zonas para reduzir impacto de falhas localizadas.

### 7.4 Interpretação de 99,9%

99,9% não significa ausência de falha.  
Significa projetar a arquitetura para:

- detectar problemas rapidamente
- reduzir impacto
- recuperar com previsibilidade
- manter continuidade do serviço

---

## 8. O que está em Terraform e o que está documentado

Para este teste, o Terraform foi mantido no escopo mínimo pedido:

- VNet
- sub-redes
- identidade
- storage
- app service
- estrutura organizacional

Já componentes como:

- **Front Door + WAF**
- **Private Endpoint**

foram tratados **arquiteturalmente e documentalmente**, sem provisionamento completo.

---

## 9. Conclusão

A solução proposta busca equilíbrio entre:

- segurança
- simplicidade
- organização
- clareza de arquitetura

Os principais pontos da proposta são:

- **WAF na borda pública**
- **Private Endpoint no backend**
- **Managed Identity para autenticação**
- **NSG para regras L3/L4**
- **App Service for Containers para a API**
- **observabilidade desde o desenho**
- **alta disponibilidade tratada de forma coerente**

A arquitetura foi desenhada para ser simples, segura e defensável tecnicamente.
