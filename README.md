# Email OAuth 2.0 Proxy - Helm
Helm Chart and Docker image for [Email OAuth 2.0 Proxy](https://github.com/simonrob/email-oauth2-proxy/)

This project publishes **Docker images** and **Helm charts** to both Docker Hub and GitHub Container Registry (GHCR).

## Helm Charts

Helm charts are available in **two ways**:

### 1. OCI Registry (Recommended for Helm 3.8+)

* `oci://docker.io/pjaudiomv/email-oauth2-proxy`
* `oci://ghcr.io/pjaudiomv/email-oauth2-proxy`

Helm chart tags **always have a leading `v`**, e.g., `v1.0.0`.

**Install Example:**

```bash
helm install email-oauth2-proxy oci://docker.io/pjaudiomv/email-oauth2-proxy --version v1.0.0
# or
helm install email-oauth2-proxy oci://ghcr.io/pjaudiomv/email-oauth2-proxy --version v1.0.0
```

---

### 2. Helm Chart Repository (via index.yaml)

A standard Helm chart repo is also hosted at:

* **Repo URL:** [https://pjaudiomv.github.io/email-oauth2-proxy](https://pjaudiomv.github.io/email-oauth2-proxy)
* **Index file:** [index.yaml](https://pjaudiomv.github.io/email-oauth2-proxy/index.yaml)

**Add the repo and install:**

```bash
helm repo add email-oauth2-proxy https://pjaudiomv.github.io/email-oauth2-proxy
helm repo update
helm install email-oauth2-proxy email-oauth2-proxy --version 1.0.0
```

> **Note:**
>
> * When using the Helm chart repository (`helm repo add`), use the version without the leading `v` (e.g., `1.0.0`).
> * When using OCI, use the version **with** the leading `v` (e.g., `v1.0.0`).

---

## Docker Images

Images are available at:

* [`docker.io/pjaudiomv/email-oauth2-proxy`](https://hub.docker.com/r/pjaudiomv/email-oauth2-proxy)
* [`ghcr.io/pjaudiomv/email-oauth2-proxy`](https://github.com/pjaudiomv/email-oauth2-proxy/pkgs/container/email-oauth2-proxy)

Images are tagged with semantic versions (e.g., `1.0.0`).

**Pull Example:**

```bash
docker pull docker.io/pjaudiomv/email-oauth2-proxy:1.0.0
# or
docker pull ghcr.io/pjaudiomv/email-oauth2-proxy:1.0.0
```

---

## Table of Contents

- [Docker Usage](./docker/README.md) - Instructions for using the Docker image
- [Helm Deployment](./charts/README.md) - Helm chart documentation
