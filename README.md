# CI/CD Pipeline & AWS ECS Deployment for Portfolio Website

This repository automates the deployment of a Dockerized portfolio website using **Jenkins CI/CD** and **AWS ECS Fargate**. The pipeline builds and pushes Docker images to Docker Hub, while AWS ECS ensures scalable and cost-effective hosting.

---

## Table of Contents
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)
- [AWS ECS Deployment Guide](#aws-ecs-deployment-guide)
- [Cost Management](#cost-management)
- [Notes](#notes)

---

## Jenkins CI/CD Pipeline

### Workflow
1. **Cleanup Workspace**: Remove old files.
2. **Clone Repository**: Pull latest code from GitHub.
3. **Build Docker Image**: Create image using `Dockerfile`.
4. **Push Image to Docker Hub**: Upload to `shoaibismail18/portfolio-website:latest`.
5. **Deploy Container**: Run the container locally (optional).

🔔 **GitHub Webhook**: Triggers pipeline automatically on new commits.

### Prerequisites
- **Jenkins Server** (Latest LTS)
- **Docker** ([Installation Guide](https://www.docker.com/get-started))
- **Git** ([Installation Guide](https://git-scm.com/downloads))
- **Jenkins Plugins**: Pipeline, Git, Docker Pipeline, Credentials.

### Setup
1. **Configure Docker Hub Credentials** in Jenkins using a `Secret Text` token.
2. **Create Pipeline Job**: Use the provided `Jenkinsfile` in the repository.

---

## AWS ECS Deployment Guide

### Step 1: Create ECS Cluster
1. Navigate to **AWS ECS** → **Create Cluster** → **Networking Only (Fargate)**.
2. Name: `portfolio-cluster`.

### Step 2: Define Task
1. **Task Definition**:
   - **Family**: `portfolio-web-task`
   - **Container**: `shoaibismail18/portfolio-website:latest`
   - **Port**: `80 (TCP)`
   - **Resource Limits**: 0.25 vCPU, 0.5 GB RAM.

### Step 3: Deploy Service
1. **Service Name**: `portfolio-service`
2. **Desired Tasks**: `1`
3. **Networking**: Use default VPC, public subnets, and a security group allowing HTTP (port 80).

### Step 4: Access the Application
1. Find the **Public IP** under the task’s ENI details.
2. Visit `http://<Public-IP>`.

### Automation ###
1. Create AWS Lambda Function
1️⃣ Open AWS Lambda → Create Function
2️⃣ Select Python 3.9 as Runtime
3️⃣ Add the code in file: Lambdacode.py
4️⃣ Deploy the function

2. Set Up EventBridge Rule
1️⃣ Open AWS EventBridge → Rules
2️⃣ Click Create Rule, add Json code in file : Eventbridge_rule.json
3️⃣ Select Event Source → Docker Hub Image Push
4️⃣ Set AWS Lambda as the Target


## Cost Management
1. **Stop ECS Service**: Set **Desired Tasks** to `0` to avoid charges.
2. **Restart Service**: Set **Desired Tasks** to `1` when needed.
3. **Delete Resources**: Remove clusters, tasks, and services when unused.

---

## Notes
- **AWS Free Tier**: Covers ECS Fargate, Lambda, and EventBridge. Monitor usage via [AWS Billing](https://console.aws.amazon.com/billing/).
- **Security**: Restrict IAM policies to least privilege.
- **Scale**: Adjust CPU/memory for production workloads.


### SYSTEM DIAGRAM ###

```mermaid
flowchart TD
    subgraph Developer
        A[Developer] -->|Pushes Code| B[GitHub]
    end

    subgraph CI/CD[Jenkins CI/CD Pipeline]
        B -->|Triggers via Webhook| C[Jenkins Server]
        C --> D[Clean Workspace]
        D --> E[Clone Repository]
        E --> F[Build Docker Image]
        F --> G[Push to Docker Hub]
    end

    subgraph AWS[Cloud Deployment]
        G --> H[AWS ECS Fargate]
        H --> I[ECS Cluster: portfolio-cluster]
        I --> J[Service: portfolio-service]
        J --> K[Task: portfolio-web-task]
        K --> L[Container: portfolio-website]
    end

    subgraph EndUser
        L --> M((End Users))
        M -->|Access via| N[Public IP:80]
    end

    style A fill:#f9f,stroke:#333
    style B fill:#24292e,color:#fff
    style C fill:#D33833,color:#fff
    style G fill:#0db7ed,color:#fff
    style H fill:#FF9900,color:#000
    style N fill:#2b6cff,color:#fff
