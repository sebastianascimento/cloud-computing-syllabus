Projeto Terraform para Kubernetes com Odoo e PostgreSQL
Descrição
Este projeto utiliza o Terraform para provisionar recursos no Kubernetes, incluindo o Odoo e o PostgreSQL. Ele foi desenvolvido com o objetivo de fornecer uma solução automatizada para implantar e gerenciar esses recursos em um cluster Kubernetes. O Terraform facilita a criação, alteração e versionamento da infraestrutura de forma repetível e controlada.

Tecnologias Utilizadas
Terraform: Ferramenta de infraestrutura como código para provisionar e gerenciar recursos em nuvem.
Kubernetes: Sistema de orquestração de contêineres para automação da implantação, escalabilidade e gerenciamento de aplicações em contêiner.
Minikube: Ferramenta para criar um cluster Kubernetes localmente, ideal para ambientes de desenvolvimento.
Odoo: Aplicação de código aberto para gestão empresarial, utilizada como a aplicação principal neste projeto.
PostgreSQL: Banco de dados relacional usado para armazenar os dados do Odoo.

Estretura do projeto:
├── main.tf              # Arquivo principal de configuração do Terraform
├── variables.tf         # Definição de variáveis do projeto
├── outputs.tf           # Definição de saídas do Terraform
├── terraform.tfvars     # Arquivo de variáveis específicas de configuração
├── kubernetes.tf        # Configuração específica do Kubernetes
├── odoo.tf              # Configuração e implantação do Odoo
├── provider.tf          # Definição dos provedores utilizados (Kubernetes, etc.)
├── postgres.tf          # Configuração do banco de dados PostgreSQL
└── README.md            # Este arquivo de documentação do projeto

Requisitos
Para rodar este projeto localmente, você precisará de:

Terraform versão 1.0.0 ou superior
Minikube (ou um cluster Kubernetes funcional)
kubectl configurado para se comunicar com seu cluster Kubernetes


Como Rodar o Projeto Localmente
Passo 1: Instalar as Dependências
Antes de começar, certifique-se de ter o Terraform, Minikube, kubectl instalados no seu sistema.

Instalar o Terraform:

Para sistemas baseados em Linux:
bash
sudo apt-get install terraform
Para outros sistemas operacionais, siga as instruções oficiais.

Instalar o Minikube:

Para sistemas baseados em Linux:
bash

sudo apt-get install minikube
Para outros sistemas operacionais, siga as instruções oficiais.

Instalar o kubectl:
Para sistemas baseados em Linux:

sudo apt-get install kubectl
Para outros sistemas operacionais, siga as instruções oficiais.

Instalar o Helm:
Para sistemas baseados em Linux:

sudo apt-get install helm
Para outros sistemas operacionais, siga as instruções oficiais.
Passo 2: Iniciar o Minikube

Inicie o Minikube para criar um cluster Kubernetes local:
bash
minikube start
Isso criará um cluster Kubernetes em sua máquina local, e o kubectl será configurado automaticamente para interagir com ele.

Passo 3: Configurar o Terraform
Clone o repositório do projeto para o seu diretório local:

bash
git clone https://github.com/sebastianascimento/cloud-computing-syllabus.git
cd TF_PROJECT


Agora você pode rodar o Terraform para provisionar os recursos no Kubernetes:

Inicializar o Terraform:
terraform init

Verificar o plano de execução:
bash
terraform plan

Aplicar a configuração:
bash
terraform apply

Após a execução do Terraform, ele irá criar os deployments, services e ingressos no seu cluster Kubernetes, incluindo as configurações para o Odoo e PostgreSQL.

Passo 5: Acessar a Aplicação Localmente
Com o cluster Kubernetes rodando e os recursos provisionados, você pode acessar o Odoo localmente:


Acessar o Odoo no navegador:
Abra o navegador e acesse o Odoo utilizando o IP retornado pelo comando anterior. O serviço estará disponível no endereço:
bash

http://localhost:8069

Variáveis do Projeto
As principais variáveis de entrada são:

client_config: Mapeia as configurações do banco de dados para diferentes clientes (ex: "netflix", "meta", "rockstar").
clients: Lista de clientes que serão configurados no projeto.
environment: O ambiente de implantação (ex: "dev", "prod").
replicas: Número de réplicas para o Deployment do Odoo e PostgreSQL.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.35.1 |
| <a name="requirement_minikube"></a> [minikube](#requirement\_minikube) | 0.4.4 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.35.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.db](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/deployment) | resource |
| [kubernetes_deployment.odoo](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/deployment) | resource |
| [kubernetes_ingress.odoo_https](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/ingress) | resource |
| [kubernetes_namespace.client_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/namespace) | resource |
| [kubernetes_service.odoo_service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/service) | resource |
| [kubernetes_service.postgres_service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.35.1/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Configurações específicas de cada cliente | <pre>map(object({<br/>    db_user     = string<br/>    db_password = string<br/>    db_name     = string<br/>    db_host     = string<br/>  }))</pre> | <pre>{<br/>  "meta": {<br/>    "db_host": "db_meta",<br/>    "db_name": "meta_db",<br/>    "db_password": "meta_password",<br/>    "db_user": "meta_user"<br/>  },<br/>  "netflix": {<br/>    "db_host": "db_netflix",<br/>    "db_name": "netflix_db",<br/>    "db_password": "netflix_password",<br/>    "db_user": "netflix_user"<br/>  },<br/>  "rockstar": {<br/>    "db_host": "db_rockstar",<br/>    "db_name": "rockstar_db",<br/>    "db_password": "rockstar_password",<br/>    "db_user": "rockstar_user"<br/>  }<br/>}</pre> | no |
| <a name="input_clients"></a> [clients](#input\_clients) | Lista de clientes | `list(string)` | <pre>[<br/>  "netflix",<br/>  "meta",<br/>  "rockstar"<br/>]</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente (dev, qa, prod) | `string` | `"dev"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Número de réplicas para o Deployment | `number` | `1` | no |

## Outputs

No outputs.
