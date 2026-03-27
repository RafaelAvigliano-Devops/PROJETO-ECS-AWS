# Projeto ECS na AWS - Teste Inicial de DevOps

Este projeto demonstra a criação de uma infraestrutura básica na AWS usando Terraform para deploy de uma aplicação containerizada no ECS (Elastic Container Service). A aplicação é um site simples que permite mudar a cor de fundo, servindo como teste inicial para pipelines de DevOps.

## Arquitetura

- **VPC**: Rede privada com CIDR 10.0.0.0/16
- **Internet Gateway**: Para acesso à internet
- **Sub-redes Públicas**: Duas sub-redes em zonas de disponibilidade diferentes (us-east-1a e us-east-1b)
- **Security Groups**: Permite tráfego HTTPS (porta 443) no Load Balancer e comunicação interna
- **ECS Cluster**: Cluster Fargate para execução de containers
- **Application Load Balancer**: Balanceamento de carga com listener HTTPS na porta 443
- **ECR Repository**: Repositório para armazenar a imagem Docker da aplicação

## Pré-requisitos

- Conta AWS com permissões adequadas
- Terraform instalado (versão >= 1.0)
- Docker instalado
- AWS CLI configurado

## Como usar

1. **Clone o repositório** (se aplicável) ou navegue para o diretório do projeto.

2. **Configure as variáveis**:
   Edite o arquivo `variables.tf` ou crie um `terraform.tfvars` para personalizar:
   - Região AWS
   - CIDR da VPC
   - Zonas de disponibilidade
   - Nome da aplicação

3. **Inicialize o Terraform**:
   ```bash
   terraform init
   ```

4. **Planeje o deploy**:
   ```bash
   terraform plan
   ```

5. **Aplique as mudanças**:
   ```bash
   terraform apply
   ```

6. **Build e push da imagem Docker**:
   ```bash
   # Build da imagem
   docker build -t color-changer-app .

   # Login no ECR
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

   # Tag da imagem
   docker tag color-changer-app:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/color-changer-app:latest

   # Push da imagem
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/color-changer-app:latest
   ```

7. **Acesse a aplicação**:
   Após o deploy, acesse o DNS do Load Balancer na porta 443 (HTTPS).

## Testes de DevOps

Este projeto serve como base para testes de:

- **Infraestrutura como Código**: Uso do Terraform para provisionamento
- **Containerização**: Aplicação em container Docker
- **CI/CD**: Integração com pipelines para build e deploy automático
- **Monitoramento**: Logs no CloudWatch
- **Escalabilidade**: ECS permite ajuste automático de tarefas
- **Segurança**: Uso de Security Groups e HTTPS

## Limpeza

Para remover todos os recursos criados:

```bash
terraform destroy
```

## Notas

- O certificado ACM está configurado com um domínio placeholder. Substitua por um domínio válido e configure a validação DNS.
- Para produção, considere usar Route 53 para DNS e ACM para certificados gerenciados.
- Adicione monitoramento com CloudWatch alarms e auto-scaling policies conforme necessário.