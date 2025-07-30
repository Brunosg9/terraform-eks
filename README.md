# terraform-eks
Workflow with terraform, aws and pipelines.

## Configuração do EKS com ArgoCD

Este projeto inclui um playbook Ansible para configurar automaticamente:
- AWS Load Balancer Controller
- ArgoCD para GitOps
- Políticas IAM necessárias
- Configurações de segurança

### Pré-requisitos

1. **AWS CLI configurado**
   ```bash
   aws configure
   ```

2. **kubectl configurado para o cluster EKS**
   ```bash
   aws eks update-kubeconfig --region us-east-1 --name eks-cluster-prd
   ```

3. **Helm instalado**
   ```bash
   curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
   ```

4. **Ansible instalado**
   ```bash
   pip install ansible
   ```

### Execução

1. **Executar o script automatizado:**
   ```bash
   ./run-ansible.sh
   ```

2. **Ou executar o playbook diretamente:**
   ```bash
   ansible-playbook -i inventory.ini ansible.yml -v
   ```

### Componentes Instalados

#### AWS Load Balancer Controller
- Política IAM: `AWSLoadBalancerControllerIAMPolicy`
- Role IAM: `AmazonEKSLoadBalancerControllerRole`
- Service Account: `aws-load-balancer-controller`

#### ArgoCD
- Namespace: `argocd`
- Política IAM: `ArgoCDIAMPolicy` (ECR, Secrets Manager, SSM)
- Role IAM: `ArgoCDServiceRole`
- Ingress configurado para ALB
- RBAC configurado
- Network Policies aplicadas

### Acesso ao ArgoCD

#### Método 1: Port Forward
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Acesse: https://localhost:8080

#### Método 2: Ingress (após configurar DNS)
Acesse: https://argocd.yourdomain.com

#### Credenciais Iniciais
- **Usuário:** admin
- **Senha:** 
  ```bash
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  ```

### Configurações Pós-Instalação

1. **Alterar senha do admin:**
   ```bash
   argocd account update-password
   ```

2. **Configurar certificado SSL:**
   - Atualize o ARN do certificado no arquivo `argocd-ingress.yaml`
   - Configure o DNS para apontar para o ALB

3. **Configurar repositório Git:**
   - Adicione seu repositório no ArgoCD UI
   - Configure as credenciais se necessário

4. **Aplicar configurações customizadas:**
   ```bash
   kubectl apply -f argocd-config.yaml
   ```

### Estrutura de Arquivos

```
terraform-eks/
├── ansible.yml              # Playbook principal
├── inventory.ini            # Inventário do Ansible
├── run-ansible.sh          # Script de execução
├── argocd-config.yaml      # Configurações customizadas do ArgoCD
└── README.md               # Este arquivo
```

### Troubleshooting

#### Verificar status dos pods
```bash
kubectl get pods -n argocd
kubectl get pods -n kube-system
```

#### Verificar logs do ArgoCD
```bash
kubectl logs -n argocd deployment/argocd-server
```

#### Verificar Load Balancer Controller
```bash
kubectl logs -n kube-system deployment/aws-load-balancer-controller
```

#### Verificar políticas IAM
```bash
aws iam list-policies --query 'Policies[?PolicyName==`AWSLoadBalancerControllerIAMPolicy`]'
aws iam list-policies --query 'Policies[?PolicyName==`ArgoCDIAMPolicy`]'
```

### Próximos Passos

1. Configurar pipeline CI/CD
2. Implementar monitoramento com Prometheus/Grafana
3. Configurar backup do ArgoCD
4. Implementar políticas de segurança adicionais
5. Configurar multi-cluster com ArgoCD
