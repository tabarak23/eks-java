🚀 3-Tier Application Deployment on AWS EKS

This project demonstrates a production-style 3-tier architecture deployed on AWS EKS, fully automated using Terraform, GitHub Actions, Docker, Helm, and Kubernetes.

It follows real-world GitOps & CI/CD best practices, including:

🏗️ Infrastructure as Code (IaC)

🔀 Pull Request–based approvals

🔁 Separate CI & CD workflows

🐳 Containerized microservices

☸️ Kubernetes orchestration with Helm

🏗️ Architecture Overview
🔹 3-Tier Architecture

🌐 Web Tier – Nginx

⚙️ Application Tier – Java Spring Application

🗄️ Data Tier – MySQL, Memcached, RabbitMQ, Elasticsearch

🧰 Platform & Tools
1. ☁️ AWS EKS
2. 🐳 Docker & Amazon ECR
3. ☸️ Kubernetes & Helm
4. 🏗️ Terraform (staging environment)
5. 🔁 GitHub Actions
6. 🔍 SonarQube
7. 🧪 Maven
8. 📊 Prometheus (Monitoring & Metrics)
9. 📈 Grafana (Visualization & Dashboards)

![image alt](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/WhatsApp%20Image%202026-02-01%20at%2012.50.57%20PM.jpeg)

## 🌿 Branching Strategy & Promotion Flow

This repository follows a two-branch strategy to ensure safe testing and controlled production releases.

### 🌱 Branches

1. **staging branch**
   1. Used for development, testing, and validation
   2. All feature changes are merged here first
   3. CI workflows (build, test, SonarQube) run on this branch
   4. No production changes are applied from this branch

2. **main branch**
   1. Represents the production-ready state
   2. Protected branch with required Pull Request approvals
   3. Only approved and tested changes are merged here

### 🔁 Promotion Workflow (Staging → Production)

1. Developers push changes to the `staging` branch
2. CI pipeline runs:
   1. Build & unit tests
   2. SonarQube quality checks
   3. Docker image build
3. If all checks pass, a Pull Request is raised from `staging` → `main`
4. Pull Request requires manual approval
5. After approval and merge:
   1. Terraform `apply` runs only on `main`
   2. Application is deployed to production EKS using Helm

## 🔁 CI/CD Workflow Summary

### 🏗️ terraform-infra.yml

1. Runs terraform plan on Pull Requests
2. Requires Pull Request approval
3. Runs terraform apply only on the main branch

### 🚀 deploy.yml

1. Maven build & unit tests
2. SonarQube code quality scan
3. Docker image build
4. Push Docker image to Amazon ECR
5. Deploy application to AWS EKS using Helm

## 📊 Monitoring & Observability

This project includes **full-stack monitoring and observability** using **Prometheus and Grafana**, deployed on **AWS EKS**.

### 🔎 Monitoring Stack

1. 📊 **Prometheus**
   - Collects Kubernetes and application metrics
   - Scrapes metrics from pods, nodes, and services
   - Provides time-series monitoring for cluster health

2. 📈 **Grafana**
   - Visualizes Prometheus metrics using dashboards
   - Provides real-time insights into application and cluster performance
   - Used for monitoring:
     - CPU & memory usage
     - Pod and node health
     - Application performance metrics

### ⚙️ Integration Details

1. Prometheus and Grafana are deployed inside the EKS cluster
2. Metrics are collected from Kubernetes workloads and infrastructure
3. Dashboards help in proactive monitoring and troubleshooting
4. Enables production-grade observability and alert readiness

## 🔐 Security & Best Practices

1. PR-based infrastructure changes
2. Manual approval before production changes
3. Separate CI and CD pipelines
4. No direct terraform apply from feature branches
5. Immutable Docker images
6. Kubernetes secrets managed via manifests
7. Monitoring with Prometheus
8. Visualization with Grafana




```
.
├── .github/
│   └── workflows/
│       ├── terraform-infra.yml        # Terraform CI/CD (plan on PR, apply on main)
│       └── deploy.yml                 # App CI/CD (test, build, SonarQube, ECR, Helm)
│
├── terraform/                         # Infrastructure as Code (AWS)
│   ├── eks-cluster.tf                 # EKS cluster and node groups
│   ├── vpc.tf                         # VPC, subnets, routing
│   ├── main.tf                        # Core Terraform configuration
│   ├── terraform.tf                  # Terraform backend & providers
│   ├── variables.tf                  # Input variable definitions
│   ├── outputs.tf                    # Terraform outputs
│   ├── main.tfvars                   # Default variable values
│   └── staging.tfvars                # Staging environment variables
│
├── Docker-files/                      # Dockerfiles per application tier
│   ├── app/
│   │   └── Dockerfile                # Java application image
│   ├── web/
│   │   ├── Dockerfile                # Nginx web tier image
│   │   └── nginvproapp.conf           # Nginx configuration
│   └── db/
│       ├── Dockerfile                # Database image
│       └── db_backup.sql              # Initial database data
│
├── helm/                              # Helm charts for EKS deployment
│   └── vprofilecharts/
│       ├── Chart.yaml                # Helm chart metadata
│       ├── values.yaml               # Default Helm values
│       └── templates/                # Kubernetes resource templates
│           ├── vproappdep.yml         # Application deployment
│           ├── vproapp-service.yml    # Application service
│           ├── vprodbdep.yml          # Database deployment
│           ├── db-CIP.yml             # Database ClusterIP service
│           ├── rmq-dep.yml            # RabbitMQ deployment
│           ├── rmq-CIP-service.yml    # RabbitMQ service
│           ├── mcdep.yml              # Memcached deployment
│           ├── mc-CIP.yml             # Memcached service
│           ├── app-secret.yml         # Application secrets
│           └── vproingress.yaml       # Ingress configuration
│
├── kubernetes/                        # Raw Kubernetes manifests (reference only)
│   └── vpro-app/
│       ├── vproappdep.yml             # Application deployment
│       ├── vproapp-service.yml        # Application service
│       ├── vprodbdep.yml              # Database deployment
│       ├── db-CIP.yml                 # Database service
│       ├── rmq-dep.yml                # RabbitMQ deployment
│       ├── rmq-CIP-service.yml        # RabbitMQ service
│       ├── mcdep.yml                  # Memcached deployment
│       ├── mc-CIP.yml                 # Memcached service
│       ├── app-secret.yml             # Secrets
│       └── vproingress.yaml           # Ingress
│
├── src/                               # Java application source code
├── images/                            # Architecture & pipeline screenshots
├── Dockerfile                         # Root application Dockerfile
├── compose.yaml                       # Local Docker Compose setup
└── README.md

```



```
VProfile – Local Setup (Docker)

This project runs a 3-tier Java application (Nginx + Tomcat + MySQL) using Docker Compose.

Prerequisites

Docker ≥ 20.x

Docker Compose v2

step 1)Clone the repository
git clone https://github.com/tabarak23/eks-java.git
cd eks-java
```

Step 2) Build Docker images

![image alt](https://github.com/tabarak23/eks-java/blob/9748eeefb2c0b989a5440728dbbba32d0d0b5ff7/images/Screenshot%20from%202026-01-31%2015-21-00.png)  

command = docker compose build


Step 3) Start the application

![image alt](https://github.com/tabarak23/eks-java/blob/46da6c93b6e3d310ca87590f58a5f9118ff4e21b/images/Screenshot%20from%202026-01-31%2014-34-06.png)

command = docker compose up -d

Step 4) Access the Application 

![image alt](https://github.com/tabarak23/eks-java/blob/46da6c93b6e3d310ca87590f58a5f9118ff4e21b/images/Screenshot%20from%202026-01-31%2014-34-26.png)

http://localhost:8080

Step 5) Stop & Clean Up

![image alt](https://github.com/tabarak23/eks-java/blob/46da6c93b6e3d310ca87590f58a5f9118ff4e21b/images/Screenshot%20from%202026-01-31%2014-34-54.png)

command = docker compose down


Notes

(i)Application containers run as non-root users

(ii)Images are production-ready and Kubernetes/EKS compatible


## 🐳 Containerization

1. Each tier has its own Dockerfile:
   1. Docker-files/app – Java application
   2. Docker-files/web – Nginx web tier
   3. Docker-files/db – Database image

2. Docker images are versioned and pushed to Amazon ECR

## ☸️ Kubernetes & Helm

1. Kubernetes resources are managed using Helm
  ### Includes

1. Deployments
2. Services
3. Secrets
4. Ingress
5. ConfigMaps

2. Helm charts are located at: helm/vprofilecharts/
   ### Helm Enables

  1. Versioned deployments
  2. Easy rollbacks
  3. Environment-specific configuration









## 🔍 SonarCloud Setup

Follow the steps below to integrate SonarCloud with this repository.

### 🧭 SonarCloud Configuration

1. Go to https://sonarcloud.io
   ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-19-04.png)
2. Sign up or log in using your GitHub account
    ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-19-11.png)
3. Create a new organization
   ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-20-37.png)
   1. Choose **Create manually**
      ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-20-46.png)
   3. Enter the organization name
      ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-21-31.png)
   5. Select the **Free plan**
   7. Click **Create Organization**
      ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-21-47.png)


6. Click **Analyze new project**
     ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-22-13.png)
8. Enter the project name
    ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-22-41.png)
10. Select the previous version (if prompted)
    Click **Create Project**
    ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-22-59.png)


### 🔐 Generate SonarCloud Token

1. Navigate to **My Organizations**
   Select your organization
       ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-23-24.png)
4. Go to **Security**
6. Enter a name for the token
7. Click **Generate Token**
8. Copy the generated token
   ![image](https://github.com/tabarak23/eks-java/blob/e83e91c02a419d87b9e0415d06fbac653c1639ad/images/Screenshot%20from%202026-01-31%2021-26-55.png)

### 🔑 GitHub Secrets Configuration

1. Go to your GitHub repository
2. Navigate to **Settings → Secrets and variables → Actions**
3. Click **New repository secret**
4. Add the SonarCloud token:
   - **Name:** `SONAR_TOKEN`
   - **Value:** *(Paste the copied token)*
5. Save the secret




SUCCESS


![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-32-48.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-33-00.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-26-34.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2011-40-39.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-29-08.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-28-36.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-28-28.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-28-05.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-27-22.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-26-57.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-26-34.png)
![image](https://github.com/tabarak23/eks-java/blob/ed48dda421f10bf7639dbf8bb0a2e2c44eb42068/images/Screenshot%20from%202026-02-01%2012-26-34.png)





