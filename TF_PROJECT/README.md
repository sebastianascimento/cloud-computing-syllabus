# Terraform Project for Kubernetes with Odoo and PostgreSQL

## Technologies Used

- **Terraform** 
- **Kubernetes** 
- **Minikube**
- **Odoo**

## Project Structure

├── main.tf              
├── variables.tf         
├── outputs.tf           
├── terraform.tfvars     
├── kubernetes.tf        
├── odoo.tf              
├── provider.tf          
├── postgres.tf         
└── README.md           


## How to Run the Project Locally

### Step 1: Install Dependencies

Before starting, ensure that Terraform, Minikube  and kubectl are installed on your system.

### Step 2: Start Minikube

```bash
minikube start 
```

### Step 3: Configure Terraform

Initialize Terraform:

```bash
terraform init
```


Check execution plan:

```bash
terraform plan
```
Apply configuration:

```bash
terraform apply
```

## Step 4: Configure Ingress for HTTPS Access

If using Minikube, enable the Ingress addon:

```bash
minikube addons enable ingress
```

Now, get the Minikube IP:

```bash
minikube ip
```

Add it to your /etc/hosts file:

```bash
echo "$(minikube ip) odoo.local" | sudo tee -a /etc/hosts
```

## Step 5: Access the Application Locally


Now, you can access Odoo locally via HTTPS:

```bash
https://odoo.local
```

If a domain with a valid certificate is configured, use:

```bash
https://odoo.yourdomain.com
```




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
