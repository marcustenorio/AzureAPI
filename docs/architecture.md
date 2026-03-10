# Arquitetura da Solução

Este documento descreve as decisões arquiteturais adotadas para disponibilizar um aplicativo web e uma API de forma segura na plataforma Azure.

A solução foi projetada priorizando simplicidade operacional, segurança e boas práticas de arquitetura cloud.

---

# Visão Geral da Arquitetura

A aplicação é composta por duas camadas principais:

- **Web Application**
- **API Backend**

Essas camadas são publicadas utilizando **Azure App Service**, enquanto o armazenamento de dados é realizado em **Azure Storage Account**.

O acesso externo à aplicação é controlado por **Azure Front Door com WAF**, garantindo proteção contra ataques comuns em aplicações web.

O acesso ao Storage é realizado utilizando **Managed Identity**, evitando o uso de segredos ou credenciais armazenadas na aplicação.

---

# Componentes da Arquitetura

## Azure Front Door + WAF

Responsável pela **segurança de borda da aplicação**.

Funções principais:

- ponto de entrada público da aplicação
- inspeção de tráfego HTTP/HTTPS
- proteção contra ataques conhecidos (OWASP)
- centralização da borda pública

Esse componente evita que o App Service seja exposto diretamente à internet.

---

## Azure App Service (Web)

Hospeda a camada web da aplicação.

Responsabilidades:

- servir interface web
- encaminhar requisições para a API
- executar em ambiente gerenciado sem necessidade de gerenciar infraestrutura

---

## Azure App Service (API Container)

Hospeda a API da aplicação.

A API foi desenvolvida em **Python (FastAPI)** e executa dentro de um container.

Responsabilidades:

- expor endpoints REST
- executar lógica de negócio
- acessar o Storage Account utilizando identidade gerenciada

---

## Azure Storage Account

Responsável pelo armazenamento de dados da aplicação.

Características de segurança adotadas:

- acesso realizado via **Managed Identity**
- controle de acesso via **RBAC**
- nenhuma credencial armazenada na aplicação

---

# Identidade e Autenticação

Para acesso aos recursos Azure foi adotado o uso de **Managed Identity**.

Isso permite que a aplicação autentique automaticamente no Azure sem uso de:

- connection strings
- chaves de acesso
- segredos armazenados

O fluxo de autenticação é:

App Service → Managed Identity → Azure RBAC → Storage Account

---

# Segurança de Borda

A solução utiliza dois mecanismos de segurança complementares.

## WAF (Web Application Firewall)

Aplicado na borda da aplicação via Azure Front Door.

Proteções fornecidas:

- inspeção de requisições HTTP
- mitigação de ataques OWASP
- filtragem de payloads maliciosos
- controle de padrões de requisição

---

## Private Endpoint

Para serviços de backend como Storage, recomenda-se o uso de **Private Endpoint** para evitar exposição pública.

No cenário proposto, o Storage é acessado apenas pela aplicação, reduzindo a superfície de ataque.

---

# Conclusão

A arquitetura proposta segue boas práticas de cloud computing:

- separação clara entre camadas
- controle de acesso baseado em identidade
- segurança de borda com WAF
- redução de exposição de serviços internos

Essa abordagem fornece um equilíbrio adequado entre segurança, simplicidade operacional e escalabilidade.
