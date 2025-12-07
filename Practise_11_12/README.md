## Yandex Managed Service for Kubernetes (MKS)

### 1. Установка NGINX Ingress controller

Через Marketplace (Ingress NGINX) или через Helm:

```bash
kubectl create namespace nginx
kubectl config set-context --current --namespace nginx

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
kubectl get svc -n nginx
````

Скопируй значение `EXTERNAL-IP` у сервиса `ingress-nginx-controller`.

### 2. Настройка DNS в Yandex Cloud

```bash
yc dns zone add-records <YOUR_ZONE_ID> \
  --record "*.nginx.<YOUR_DOMAIN>. 60 A <EXTERNAL_IP>"
```

После этого домен `app.nginx.<YOUR_DOMAIN>` (который указан в `values.yaml`) будет указывать на Ingress.

### 3. Деплой приложения через Helm

```bash
kubectl config set-context --current --namespace production
kubectl create namespace production || true

helm install my-web-app ./helm-charts/my-web-app -n production

kubectl get pods -n production
kubectl get svc -n production
kubectl get ingress -n production
```

Проверка:

```bash
curl http://app.nginx.<YOUR_DOMAIN>/
curl http://app.nginx.<YOUR_DOMAIN>/api
curl http://app.nginx.<YOUR_DOMAIN>/health
```
