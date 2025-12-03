🚀 AutoServe Cloud – DevOps Practice Project

FastAPI • Docker • Terraform • Azure • GitHub Actions (CI/CD) • ACR • SonarQube • Snyk (hooks)

📌 Overview

AutoServe Cloud is a hands-on DevOps project I built to practice and demonstrate real-world skills across:

Cloud Engineering (Azure)

Infrastructure as Code (Terraform)

CI/CD (GitHub Actions)

Containerisation (Docker)

Security & Quality (Snyk + SonarQube hooks)

Automation & Versioned Deployments

Private Container Registry (ACR)

The application is a small FastAPI-based booking service designed to simulate production-grade DevOps workflows end-to-end.

🧱 Architecture

The system is structured as:

Application Layer

Written in FastAPI (Python)

Includes:

/healthz endpoint for health checks

Simple booking endpoints (GET /bookings, POST /bookings)

Fully containerised with Docker

Infrastructure Layer (Terraform)

Provisioned using Terraform:

Azure Resource Group

Azure Container Registry (ACR)
Used to store versioned Docker images built by CI/CD

Note: Due to quota limits on my personal Azure subscription for App Service compute, deployment stops at ACR. In a real customer project, the same pipeline would deploy into Azure App Service, AKS, or Container Apps.

CI/CD (GitHub Actions)

CI Stage

Runs on every push/PR to main

Installs dependencies

Runs unit tests (pytest)

Includes clear hooks for:

SonarQube (code quality)

Snyk (dependency & container vulnerability scanning)

CD Stage (Only on main branch)

Logs into Azure using Service Principal (AZURE_CREDENTIALS)

Logs into ACR securely

Builds and tags docker image using short commit SHA

Pushes image to Azure Container Registry

This creates a fully automated flow:
source → test → build → version → push → ready for deploy.

📂 Repository Structure
autoserve-cloud/
│
├── app/
│   ├── __init__.py
│   └── main.py                  # FastAPI app
│
├── tests/
│   └── test_health.py           # pytest health check
│
├── terraform/
│   ├── main.tf                  # RG + ACR IaC
│   ├── variables.tf
│   ├── providers.tf
│   └── outputs.tf
│
├── Dockerfile                    # container definition
├── requirements.txt              # Python deps
│
└── .github/workflows/
    └── ci-cd.yml                # GitHub Actions pipeline

🧪 Unit Testing

Tests run automatically in CI:

test_health.py checks the /healthz endpoint

PYTHONPATH=. ensures modules are properly imported in GitHub Actions

🔐 Security & Quality (Hooks Included)

Even though they're commented out in this version, the pipeline includes ready-made placeholders for:

SonarQube/SonarCloud scanning

Snyk security scanning

Python dependencies

Docker image scanning

This shows awareness of:

Shift-left security

Secure engineering practices

Pipeline gating

🐳 Running the App Locally

Build:

docker build -t autoserve-api .


Run:

docker run -p 8000:8000 autoserve-api


Test:

http://localhost:8000/healthz
http://localhost:8000/docs

☁️ Pulling the Image From ACR (Validation)
ACR_NAME=<your_acr>
ACR_LOGIN_SERVER=$(az acr show -n $ACR_NAME --query loginServer -o tsv)
ACR_USERNAME=$(az acr credential show -n $ACR_NAME --query username -o tsv)
ACR_PASSWORD=$(az acr credential show -n $ACR_NAME --query "passwords[0].value" -o tsv)

docker login $ACR_LOGIN_SERVER -u $ACR_USERNAME -p $ACR_PASSWORD

docker pull $ACR_LOGIN_SERVER/autoserve-api:<tag>

🎯 What This Project Demonstrates (Interview Points)
1. Infrastructure as Code

Terraform modules for Azure resources

Remote container registry provisioning

Idempotency and reproducibility

2. Continuous Integration

Automated tests

Python environment setup

Linting/scanning hooks ready

3. Continuous Deployment

Azure authentication via service principal

Automated container builds

Automated tag/versioning

Push to ACR

4. Cloud & Containerisation

Private registry usage

Secure image storage

Image pull authentication

Dockerfile best practices (non-root user, slim image)

5. DevOps Mindset

Security-first (Sonar/Snyk ready)

Observability awareness (/healthz)

Automation everywhere possible

Immutable artifact creation (SHA-tagged images)

🚀 Next Enhancements (If asked in interview)

Deploy image into AKS with Helm chart

Add Application Gateway (WAF) + HTTPS

Configure Azure Monitor + Log Analytics

Add full SonarQube/Snyk integration

Use Key Vault for secrets

Implement GitOps (ArgoCD or Flux)

🏁 Summary

AutoServe Cloud is a deliberately small but fully functional DevOps project that demonstrates:

✔ Azure cloud engineering
✔ Terraform IaC
✔ Docker containerisation
✔ Private image registry flows
✔ CI + CD pipelines
✔ Security/quality awareness
✔ Real-world DevOps patterns
