# Plano de Observabilidade

Este documento descreve a estratégia de observabilidade proposta para a aplicação.

Observabilidade é essencial para garantir visibilidade sobre o comportamento do sistema em produção, permitindo detectar falhas, degradações de desempenho e incidentes operacionais.

---

# Objetivos da Observabilidade

A estratégia adotada busca responder rapidamente às seguintes perguntas:

- A aplicação está disponível?
- Qual o tempo de resposta das requisições?
- Existe aumento de erros?
- Existem gargalos de desempenho?

---

# Componentes de Observabilidade

## Application Insights

O serviço recomendado para observabilidade da aplicação é o **Azure Application Insights**.

Ele permite coletar automaticamente:

- métricas de performance
- logs da aplicação
- traces de requisições
- dependências externas

Principais métricas monitoradas:

- tempo de resposta das requisições
- taxa de erro HTTP
- número de requisições por minuto
- exceções da aplicação

---

## Monitoramento de Infraestrutura

A infraestrutura pode ser monitorada via **Azure Monitor**, que permite acompanhar:

- utilização de CPU
- consumo de memória
- disponibilidade do App Service
- métricas do Storage

---

# Health Checks da Aplicação

A API expõe endpoints simples de verificação de saúde.

Exemplo:
/health
/ready


Esses endpoints permitem verificar se:

- a aplicação está ativa
- a API está pronta para receber tráfego

---

# Logs da Aplicação

Logs estruturados devem ser gerados pela aplicação para registrar eventos importantes, como:

- falhas de acesso ao Storage
- exceções internas
- falhas de autenticação
- erros de requisição

Esses logs podem ser enviados para o Application Insights para análise posterior.

---

# Alertas Operacionais

Alertas podem ser configurados para situações críticas:

- aumento de erros HTTP 5xx
- tempo de resposta elevado
- indisponibilidade da aplicação

Esses alertas permitem ação rápida da equipe operacional.

---

# Conclusão

A estratégia de observabilidade proposta utiliza ferramentas nativas da plataforma Azure, fornecendo visibilidade sobre:

- saúde da aplicação
- desempenho
- erros operacionais

Essa abordagem permite detectar rapidamente incidentes e melhorar a confiabilidade da aplicação em produção.

