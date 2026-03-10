AzureAPI

Arquitetura de referência para exposição segura de uma API interna no Azure.
O objetivo desta entrega é demonstrar:

- Arquitetura Segura;
- Separação de camadas;
- Uso de Terraform;
- Uso de Managed Identity;
- Observabilidade;
- Pipeline CI.

Repositório: https://github.com/marcustenorio/AzureAPI

Arquitetura composta por:

- Azure Front Door + WAF;
- VNet com subnets separadas;
- NSG;
- Storage Account privado;
- Managed Identity;
- Observabilidade via Azure Monitor.


Validação:

terraform init
terraform validate
terraform plan
