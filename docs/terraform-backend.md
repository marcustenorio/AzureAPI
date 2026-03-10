# Backend do Terraform

Este documento descreve a estratégia adotada para gerenciamento do estado do Terraform.

---

# Por que usar Backend Remoto

O Terraform mantém um arquivo chamado **state** que representa o estado atual da infraestrutura.

Armazenar esse arquivo localmente pode causar problemas em ambientes colaborativos, como:

- conflitos entre usuários
- perda de estado
- inconsistência entre ambientes

Por esse motivo, é recomendável utilizar um **backend remoto**.

---

# Azure Blob Storage como Backend

Neste projeto foi adotado **Azure Blob Storage** para armazenar o state do Terraform.

Principais vantagens:

- armazenamento centralizado
- controle de acesso via Azure RBAC
- integração nativa com Terraform
- maior segurança operacional

---

# Estrutura do Backend

O backend é definido no arquivo: terraform/environments/dev/backend.tf


Exemplo de configuração:

terraform {
backend "azurerm" {
resource_group_name = "rg-terraform-state"
storage_account_name = "stterraformstate"
container_name = "tfstate"
key = "dev.terraform.tfstate"
}
}

---

# Arquivo de Configuração Exemplo

O projeto inclui um exemplo de configuração em: terraform/backend.hcl.example


Esse arquivo serve como referência para configurar o backend remoto em ambientes reais.

---

# Segurança do Backend

Boas práticas adotadas:

- acesso ao Storage controlado por RBAC
- separação entre ambientes
- uso de identidade federada para pipelines

---

# Conclusão

Utilizar Azure Blob Storage como backend remoto melhora a confiabilidade do gerenciamento de infraestrutura e facilita o trabalho colaborativo com Terraform.

