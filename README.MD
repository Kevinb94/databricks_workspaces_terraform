# Databricks Workspaces with Terraform (Multi-Cloud: AWS / Azure / GCP)

This project provisions **Databricks workspaces using Terraform** with a clean, modular, multi-environment, multi-cloud architecture.

It supports:

- AWS, Azure, and GCP deployments
- Shared networking per cloud
- Separate Dev and Prod environments
- Isolated Terraform state per stack
- Account-level Databricks provisioning
- Modular Infrastructure-as-Code design

---

## Architecture Overview

The infrastructure is organized by **cloud → environment → stack**:

<pre>
databricks-terraform/
├── modules/
│   ├── aws/
│   │   ├── network/
│   │   ├── storage/
│   │   └── iam/
│   ├── azure/
│   │   ├── network/
│   │   ├── storage/
│   │   └── identity/
│   └── gcp/
│       ├── network/
│       ├── storage/
│       └── iam/
├── stacks/
│   ├── aws/
│   │   ├── shared/
│   │   ├── dev/
│   │   └── prod/
│   ├── azure/
│   │   ├── shared/
│   │   ├── dev/
│   │   └── prod/
│   └── gcp/
│       ├── shared/
│       ├── dev/
│       └── prod/
└── docs/
</pre>

---

## Design Principles

### Cloud-specific infrastructure
Each cloud contains provider-native modules for networking, storage, and identity (VPC/VNet, S3/ADLS/GCS, IAM, etc.). This keeps AWS/Azure/GCP differences isolated and maintainable.

### Cloud-agnostic Databricks modules
Reusable Databricks modules handle workspace provisioning and common workspace configuration (compute, Unity Catalog, access controls), parameterized per cloud.

---

## Authentication

This project relies on **environment variables** for authentication. No secrets are stored in Terraform files.

### Databricks
```bash
export DATABRICKS_ACCOUNT_ID="your_account_id"
export DATABRICKS_CLIENT_ID="your_client_id"
export DATABRICKS_CLIENT_SECRET="your_client_secret"
```

### AWS
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_REGION="us-east-1"
```

### AZURE
```bash
export ARM_CLIENT_ID="your_client_id"
export ARM_CLIENT_SECRET="your_client_secret"
export ARM_SUBSCRIPTION_ID="your_subscription_id"
export ARM_TENANT_ID="your_tenant_id"
```

### GCP
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account.json"
export GOOGLE_PROJECT="your_project_id"
```
