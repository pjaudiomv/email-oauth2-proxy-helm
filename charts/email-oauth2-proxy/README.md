# Email OAuth2 Proxy Helm Chart

This Helm chart deploys the Email OAuth2 Proxy, which provides OAuth2 authentication for email services (IMAP, POP3, SMTP).

## Installation

### Add the Helm repository
```bash
helm repo add pjaudiomv https://pjaudiomv.github.io/email-oauth2-proxy
helm repo update
```

### Install the chart
```bash
# Install with default configuration
helm install email-oauth2-proxy pjaudiomv/email-oauth2-proxy

# Install with custom values
helm install email-oauth2-proxy pjaudiomv/email-oauth2-proxy \
  --set image.tag=1.0.0
```

## Configuration

The following table lists the configurable parameters of the email-oauth2-proxy chart and their default values.

| Parameter            | Description                         | Default                                  |
|----------------------|-------------------------------------|------------------------------------------|
| `image.repository`   | Image repository                    | `docker.io/pjaudiomv/email-oauth2-proxy` |
| `image.tag`          | Image tag                           | `1.0.0`                                  |
| `image.pullPolicy`   | Image pull policy                   | `Always`                                 |
| `image.pullSecrets`  | Image pull secrets                  | `[{name: private-registry}]`             |
| `service.type`       | Kubernetes service type             | `ClusterIP`                              |
| `service.ports`      | Service ports configuration         | See values.yaml                          |
| `resources.limits`   | Pod resource limits                 | `{cpu: 500m, memory: 512Mi}`             |
| `resources.requests` | Pod resource requests               | `{cpu: 100m, memory: 128Mi}`             |
| `nodeSelector`       | Node labels for pod assignment      | `{}`                                     |
| `tolerations`        | Tolerations for pod assignment      | `[]`                                     |
| `affinity`           | Affinity for pod assignment         | `{}`                                     |
| `args`               | Additional command line arguments   | `[]`                                     |
| `config`             | Application configuration           | `{}`                                     |
| `setupPod.enabled`   | Enable setup pod                    | `false`                                  |
| `configMap.enabled`  | Enable custom config from ConfigMap | `false`                                  |
| `configMap.name`     | ConfigMap name                      | `emailproxy-config`                      |
| `configMap.key`      | ConfigMap key                       | `emailproxy.config`                      |
