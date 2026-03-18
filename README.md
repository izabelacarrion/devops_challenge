# DevOps Challenge

Projeto desenvolvido para demonstrar uma esteira simples de entrega com **Python**, **Docker**, **Kubernetes**, **GitHub Actions** e **Terraform**.

## Visão geral

A aplicação expõe um endpoint HTTP `/health` na porta `8080`, retornando um JSON com informações básicas de status, versão e ambiente. A variável de ambiente utilizada pela aplicação é `APP_ENV`.

Exemplo de resposta:

```json
{
  "status": "ok",
  "version": "1.0.0",
  "environment": "development"
}
```

<img width="527" height="142" alt="image" src="https://github.com/user-attachments/assets/c0b97215-f5ec-4e68-b588-fd26b0c7115d" />


## Estrutura do projeto
```
.
├── .github/
│   └── workflows/
│       ├── docker.yaml
│       ├── k8s.yaml
│       ├── terraform.yaml
│       └── terraform-destroy.yaml
└── projeto/
    ├── app/
    │   └── app.py
    ├── docker/
    │   └── Dockerfile
    ├── k8s/
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   └── ingress.yaml
    └── Terraform/
        ├── main.tf
        ├── provider.tf
        ├── variables.tf
        ├── outputs.tf
        └── modules/
```

### 🐳 Docker

Contém os arquivos necessários para a containerização da aplicação.

#### ✅ O que foi implementado

- Dockerfile baseado em imagem oficial 
- Utilizado imagem do alpine por ser de um tamanho menor
- Execução com usuário **não-root**  
- Exposição da porta `8080`  
- Build simples e eficiente  

#### 🧠 Decisões tomadas

- Uso de imagem oficial para confiabilidade e suporte  
- Execução sem privilégios elevados 

#### 🔒 Melhorias possíveis

- Implementar **multi-stage build**  
- Reduzir número de camadas  
- Melhorar caching de dependências  

### ☸️ Kubernetes

Contém os manifestos Kubernetes para deploy da aplicação.

#### 📄 Arquivos presentes

**Deployment**
- Define réplicas da aplicação  
- Configura `requests` e `limits` de CPU/memória  
- Injeta variável de ambiente `APP_ENV`  

**Service**
- Expõe a aplicação dentro do cluster  

**Ingress**
- Permite acesso externo à aplicação via HTTP  

### ⚙️ Pipeline (CI/CD)

O projeto inclui pipeline automatizada para:

- Build da imagem Docker (com Push da imagem para o Docker Hub)
- Validação do manifesto do K8s
- Deploy de estrutura na Cloud AWS utilizando o Terraform
- Scan de vulnerabilidades com **Trivy**
- Scan de configurações aplicadas no Terraform usando o TFSec
  

#### ✅ Boas práticas aplicadas

- Versionamento de imagem (evitando `latest`)  
- Integração com segurança (DevSecOps)  
- Automação do processo de build  

### 🌍 Terraform

Contém a infraestrutura como código (IaC) utilizada para provisionar recursos na cloud.

#### 📄 O que é provisionado

- Criação de rede (VPC, subnets, etc.)  
- Provisionamento de instâncias (EC2)  
- Configuração de recursos necessários para execução da aplicação  

#### 🧠 Boas práticas aplicadas

- Uso de variáveis para parametrização do ambiente  
- Separação de responsabilidades em módulos  
- Código reutilizável e organizado  
- Versionamento da infraestrutura  
- Uso de backend remoto via S3
