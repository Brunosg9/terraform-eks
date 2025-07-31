# Kube-System Application

Esta aplicação do ArgoCD gerencia recursos no namespace `kube-system` do cluster EKS.

## Componentes Incluídos

### ConfigMaps
- **cluster-info**: Informações básicas do cluster (nome, região, versão)
- **monitoring-config**: Configurações de monitoramento

### Service Accounts & RBAC
- **cluster-operator**: ServiceAccount com permissões para operações básicas do cluster
- **ClusterRole**: Permissões para leitura de recursos do cluster
- **ClusterRoleBinding**: Vinculação das permissões

### Deployments
- **cluster-monitor**: Deployment para monitoramento básico do cluster

### DaemonSets
- **node-log-collector**: Coleta de logs dos nós (simulado)

### Services
- **cluster-monitor**: Service para expor o monitoramento

### Secrets
- **cluster-credentials**: Credenciais básicas do cluster
- **registry-credentials**: Credenciais para registry Docker

### Network Policies
- **kube-system-network-policy**: Políticas de rede para segurança

## Configuração

1. **Atualize o repositório Git** no arquivo `kube-system-application.yaml`:
   ```yaml
   source:
     repoURL: https://github.com/SEU-USUARIO/terraform-eks
   ```

2. **Atualize o Account ID** no arquivo `service-accounts.yaml`:
   ```yaml
   annotations:
     eks.amazonaws.com/role-arn: arn:aws:iam::SEU-ACCOUNT-ID:role/EKSClusterOperatorRole
   ```

## Deploy

Execute o script de deploy:
```bash
./deploy-kube-system-app.sh
```

Ou aplique manualmente:
```bash
kubectl apply -f argocd-applications/kube-system-application.yaml
```

## Monitoramento

Verificar status da aplicação:
```bash
kubectl get application kube-system-apps -n argocd
```

Verificar recursos criados:
```bash
kubectl get all -n kube-system -l app.kubernetes.io/managed-by=argocd
```

## Sincronização

A aplicação está configurada para sincronização automática. Para sincronizar manualmente:
```bash
kubectl patch application kube-system-apps -n argocd --type merge -p '{"operation":{"sync":{}}}'
```
