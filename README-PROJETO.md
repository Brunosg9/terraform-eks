# Projeto EKS com ArgoCD - Demonstração Completa

Este projeto demonstra a implementação completa de um cluster EKS na AWS com ArgoCD para GitOps, incluindo AWS Load Balancer Controller e aplicações de exemplo.

## 🏗️ Arquitetura do Projeto

### Componentes Principais
- **Amazon EKS Cluster** - Cluster Kubernetes gerenciado
- **ArgoCD** - Ferramenta de GitOps para deploy contínuo
- **AWS Load Balancer Controller** - Gerenciamento de ALB/NLB
- **Terraform** - Infraestrutura como código
- **Ansible** - Automação de configuração

## 📸 Demonstração Visual

### 1. Cluster EKS Criado
![EKS Cluster](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.52.25_2f70b8ae.jpg)
*Cluster EKS rodando com nodes ativos*

### 2. ArgoCD Interface
![ArgoCD Dashboard](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.52.52_df96245a.jpg)
*Interface web do ArgoCD mostrando aplicações sincronizadas*

### 3. Aplicações Deployadas
![Aplicações ArgoCD](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.53.08_b3a26f80.jpg)
*Lista de aplicações gerenciadas pelo ArgoCD*

### 4. Status das Aplicações
![Status Aplicações](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.53.25_a6d859b2.jpg)
*Detalhes do status de sincronização das aplicações*

### 5. Recursos Kubernetes
![Recursos K8s](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.53.39_d442fdfc.jpg)
*Visualização dos recursos Kubernetes deployados*

### 6. Load Balancer Controller
![ALB Controller](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.54.28_2b6530ab.jpg)
*AWS Load Balancer Controller funcionando*

### 7. Pods em Execução
![Pods Running](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.54.55_3f0b7ea3.jpg)
*Pods do sistema rodando corretamente*

### 8. Aplicação Final
![Aplicação Rodando](./Imagem%20do%20WhatsApp%20de%202025-07-30%20%C3%A0(s)%2023.55.29_b01ab920.jpg)
*Aplicação final acessível via Load Balancer*

## 🚀 Como Executar

### Pré-requisitos
```bash
# AWS CLI configurado
aws configure

# Terraform instalado
terraform --version

# kubectl configurado
kubectl version

# Ansible instalado
pip install ansible
```

### 1. Deploy da Infraestrutura
```bash
# Inicializar Terraform
cd eks/
terraform init
terraform plan
terraform apply
```

### 2. Configurar kubectl
```bash
aws eks update-kubeconfig --region us-east-1 --name eks-cluster-prd
```

### 3. Executar Ansible
```bash
# Instalar ArgoCD e Load Balancer Controller
ansible-playbook -i inventory.ini ansible.yml -v
```

### 4. Acessar ArgoCD
```bash
# Port forward
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Obter senha admin
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## 📁 Estrutura do Projeto

```
terraform-eks/
├── eks/                          # Terraform para EKS
│   ├── eks.cluster.tf           # Configuração do cluster
│   ├── eks.cluster.iam.tf       # IAM roles do cluster
│   └── variable.tf              # Variáveis
├── argocd-applications/         # Aplicações ArgoCD
├── kube-system-manifests/       # Manifests Kubernetes
├── ansible.yml                  # Playbook Ansible
└── .github/workflows/           # CI/CD pipelines
```

## 🔧 Funcionalidades Implementadas

- ✅ **Cluster EKS** com node groups
- ✅ **ArgoCD** para GitOps
- ✅ **AWS Load Balancer Controller**
- ✅ **OIDC Provider** para service accounts
- ✅ **IAM Roles** com políticas específicas
- ✅ **Automação Ansible** completa
- ✅ **CI/CD** com GitHub Actions
- ✅ **Monitoramento** de aplicações

## 🛡️ Segurança

- IAM roles com princípio do menor privilégio
- OIDC para autenticação de service accounts
- Network policies configuradas
- Secrets gerenciados pelo Kubernetes

## 📊 Monitoramento

O projeto inclui configurações para:
- Logs do cluster EKS
- Métricas do ArgoCD
- Status de health das aplicações
- Alertas de sincronização

## 🔄 GitOps Workflow

1. **Código** commitado no repositório
2. **ArgoCD** detecta mudanças
3. **Sincronização** automática
4. **Deploy** no cluster EKS
5. **Monitoramento** contínuo

## 🧹 Limpeza

```bash
# Destruir recursos
terraform -chdir=./eks destroy -auto-approve
```

---

**Projeto desenvolvido com foco em boas práticas de DevOps e GitOps** 🚀