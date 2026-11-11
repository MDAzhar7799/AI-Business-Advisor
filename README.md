# AI Global Business Growth Advisor

An AI-powered business intelligence platform that helps entrepreneurs, startups, manufacturers, and exporters make smarter business decisions using Artificial Intelligence, Machine Learning, Geographic Risk Analysis, and Global Trade Intelligence. The platform is containerized with Docker and managed end to end with four DevOps tools: **Puppet, Nagios, Terraform and Ansible**.

The system analyzes environmental risks, predicts future business growth, recommends profitable industries, identifies international demand, and helps users connect with global dealers and importers.

**Version:** 2.0 | **Author:** MD Azhar

---

## Smart Location Analysis

* Flood risk prediction
* Earthquake risk analysis
* Climate suitability analysis
* Infrastructure readiness check
* Safe zone recommendations for industries

## AI Business Growth Prediction

* Future business growth forecasting
* Market trend prediction
* Economic condition analysis
* Investment opportunity scoring

## Business Recommendation Engine

* Suggests suitable businesses for a location
* Industry-wise profitability analysis
* Raw material availability analysis
* Demand vs supply intelligence

## International Trade Intelligence

* Find countries with high product demand
* Import/export analytics
* Global market trend analysis
* International buyer/dealer suggestions
* Export opportunity recommendations

## Logistics & Export Optimization

* Trade route optimization
* Shipping cost estimation
* Port and logistics recommendations
* Supply chain intelligence

## Interactive Dashboard

* Real-time charts and graphs
* Business heatmaps
* Global trade maps
* Growth analytics dashboard

## DevOps Automation

* Infrastructure provisioning with Terraform
* Configuration management with Puppet
* Automated deployment with Ansible
* Health and availability monitoring with Nagios (NRPE)
* Containerized deployment with Docker and an automated GitHub Actions CI/CD pipeline

---

# Project Workflow

```text
User Input
   ↓
Location + Business Data Collection
   ↓
Risk Analysis (Flood/Earthquake/Climate)
   ↓
AI/ML Prediction Models
   ↓
Business Recommendation Engine
   ↓
International Market Analysis
   ↓
Dealer & Export Suggestions
   ↓
Dashboard Visualization
```

## DevOps Workflow

```text
Code Push (GitHub)
   ↓
GitHub Actions: Build Docker image + health test
   ↓
Push image to Docker Hub
   ↓
Terraform   → provisions infrastructure (VMs, network)
   ↓
Puppet      → configures servers to the desired state
   ↓
Ansible     → deploys the application using playbooks
   ↓
Nagios      → monitors health, resources and alerts
```

---

# Project Structure

```bash
AI-Business-Advisor/
│
├── .github/
│   └── workflows/
│       └── docker-deploy.yml          # CI/CD: build, test, push to Docker Hub
│
├── frontend/                          # React.js dashboard frontend
│   ├── public/
│   ├── src/
│   ├── components/
│   ├── pages/
│   ├── services/
│   └── assets/
│
├── backend/                           # Flask backend APIs
│   ├── routes/
│   ├── controllers/
│   ├── models/
│   ├── utils/
│   ├── middleware/
│   └── app.py
│
├── ml_models/                         # Machine Learning models
│   ├── flood_prediction/
│   ├── earthquake_risk/
│   ├── business_growth/
│   └── recommendation_engine/
│
├── datasets/                          # Training datasets
│   ├── climate_data/
│   ├── earthquake_data/
│   ├── trade_data/
│   └── population_data/
│
├── database/                          # Database schemas and SQLite DB
│
├── docker/                            # Docker + DevOps tooling
│   ├── Dockerfile                     # App image with Puppet, Nagios, Terraform, Ansible
│   ├── docker-compose.yml             # Multi-container setup
│   ├── docker-entrypoint.sh           # Startup script for the DevOps stack
│   ├── nginx.conf                     # Reverse proxy configuration
│   ├── puppet/                        # Puppet manifests (site.pp)
│   ├── nagios/                        # nrpe.cfg + check_ai_service.sh
│   ├── terraform/                     # Terraform IaC files (.tf)
│   └── ansible/                       # Ansible playbooks (playbook.yml)
│
├── logs/                              # Application logs (mounted volume)
├── requirements.txt                   # Python dependencies
├── .dockerignore                      # Docker exclusions
├── .env.example                       # Environment variables example
└── README.md
```

---

# Technology Stack

## Frontend

* React.js
* Tailwind CSS
* Chart.js
* Leaflet.js
* Axios

## Backend

* Flask
* Python
* JWT Authentication (Flask-JWT-Extended)
* REST APIs

## Machine Learning

* Scikit-learn
* TensorFlow
* XGBoost
* Pandas
* NumPy

## Database

* Firebase
* SQLite

## APIs Used

* Google Maps API
* OpenWeather API
* USGS Earthquake API
* UN Comtrade API
* World Bank API

## DevOps & Deployment

| Tool | Role |
| ---- | ---- |
| Terraform | Infrastructure as Code: provisions VMs and networks |
| Puppet | Configuration management: keeps servers in the desired state |
| Ansible | Automation: deploys the app using playbooks |
| Nagios (NRPE) | Monitoring: server health, CPU, memory, disk, service alerts |
| Docker | Containerization |
| Docker Compose | Multi-container orchestration |
| Nginx | Reverse proxy and static file serving |
| GitHub Actions | CI/CD pipeline |

---

# The Four DevOps Tools

## 1. Puppet: Configuration Management

* Automates server configuration and software installation
* Maintains consistency across multiple servers
* Keeps required services and configurations in the desired state
* Manifests live in `docker/puppet/` and `docker/puppet/site.pp` is applied automatically at container startup

## 2. Nagios: Monitoring

* Monitors server health and application availability
* Checks CPU, memory, disk usage and running services
* Raises alerts when a monitored service becomes unavailable
* NRPE agent runs inside the app container on port `5666`; the Nagios web UI runs on port `8085`
* Custom check: `docker/nagios/check_ai_service.sh`

## 3. Terraform: Infrastructure as Code

* Automates provisioning of cloud resources such as virtual machines and networks
* Deploys the application infrastructure consistently and repeatably
* Files live in `docker/terraform/`

```bash
cd docker/terraform
terraform init
terraform plan
terraform apply
```

## 4. Ansible: Automation and Deployment

* Automates application deployment and server setup
* Uses playbooks to run multiple tasks in order
* Reduces manual configuration effort
* Playbook: `docker/ansible/playbook.yml`

```bash
ansible-playbook docker/ansible/playbook.yml --syntax-check
ansible-playbook docker/ansible/playbook.yml
```

---

# Docker

Docker allows the complete system to run in containers without modifying project files.

### 1. Clone Project

```bash
git clone https://github.com/your-username/AI-Business-Advisor.git
cd AI-Business-Advisor
```

### 2. Start Containers

```bash
cd docker
docker-compose up --build
```

### 3. Open Application

```text
AI Recommendation API → http://localhost:5000
Health check          → http://localhost:5000/health
Nagios Web UI         → http://localhost:8085
```

---

# Stop Containers

```bash
docker-compose down
```

---

# Docker Services

| Service | Container | Port | Description |
| ------- | --------- | ---- | ----------- |
| ai-recommendation-app | ai_business_app | 5000, 5666 | Flask APIs + ML models + Puppet/Nagios NRPE/Terraform/Ansible tooling |
| nagios-monitor | devops_nagios_monitor | 8085 | Nagios server and web UI |
| devops-controller | devops_automation_controller | n/a | Verifies Puppet, Nagios plugins, Terraform and Ansible, then exits |

All services share the `ai_devops_network` bridge network.

---

# Docker Files

| File | Purpose |
| ---- | ------- |
| docker/Dockerfile | Builds the app image (Python 3.10) with Puppet, Nagios NRPE and plugins, Terraform 1.6.6 and Ansible |
| docker/docker-compose.yml | Runs the app, Nagios server and DevOps controller together |
| docker/docker-entrypoint.sh | Applies Puppet, starts NRPE, verifies Terraform, syntax-checks Ansible, then launches the app |
| docker/nginx.conf | Serves the frontend, proxies `/api/` and `/health` to Flask |
| .dockerignore | Prevents unnecessary files from being copied |

---

# CI/CD Pipeline (GitHub Actions)

Defined in `.github/workflows/docker-deploy.yml`.

| Job | Trigger | What it does |
| --- | ------- | ------------ |
| build-and-test | Push / pull request to `main` or `master` | Builds the Docker image, starts the container and checks `/health` |
| deploy | Push to `main` or `master` (after tests pass) | Logs in to Docker Hub and pushes the image tagged `latest`, `v2.0` and the commit SHA |

Add these repository secrets in GitHub: `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`.

---

# Useful Docker Commands

## Run in Background

```bash
docker-compose up -d --build
```

## View Logs

```bash
docker-compose logs -f
```

## App Logs Only

```bash
docker-compose logs -f ai-recommendation-app
```

## Restart the App

```bash
docker-compose restart ai-recommendation-app
```

## Verify the DevOps Tools

```bash
docker-compose run --rm devops-controller
```

## Rebuild Without Cache

```bash
docker-compose build --no-cache
docker-compose up
```

## Remove Everything

```bash
docker-compose down -v
```

---

# Environment Variables

Copy `.env.example` to `.env`

```bash
cp .env.example .env
```

## Example `.env`

```env
FLASK_ENV=production
JWT_SECRET_KEY=your-secret-key
DATABASE_URL=sqlite:///database.db
PORT=5000

PUPPET_AUTO_APPLY=true
NAGIOS_NRPE_ENABLE=true
NAGIOSADMIN_USER=nagiosadmin
NAGIOSADMIN_PASS=change-this-password

GOOGLE_MAPS_API_KEY=your_google_maps_key
OPENWEATHER_API_KEY=your_weather_api_key
UN_COMTRADE_API_KEY=your_trade_api_key
```

---

# Example Use Cases

## Example 1

A steel manufacturing company wants to:

* Find a safe industrial location
* Avoid flood and earthquake zones
* Analyze future demand
* Find countries importing steel

The platform provides:

* Risk analysis
* Growth prediction
* Global buyer recommendations
* Export route optimization

---

## Example 2

A startup wants to launch a textile business.

The system helps with:

* Best city recommendations
* Climate and infrastructure analysis
* Market demand forecasting
* International textile importers

---

# Security Features

* JWT Authentication
* Password hashing
* Secure API routing
* Environment variable protection
* Role-based access control
* Security headers in Nginx (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
* Secrets for Docker Hub stored in GitHub Actions secrets

> **Note:** Change the default Nagios admin password before any real deployment and keep credentials in `.env`, not in `docker-compose.yml`.

---

# Future Enhancements

* Satellite image analysis
* AI-powered investment advisor
* Real-time logistics tracking
* Blockchain trade verification
* Voice-enabled AI assistant
* Live commodity price prediction
* Mobile application support

---

# Future Scalability

The architecture supports:

* Kubernetes deployment
* Cloud deployment (AWS/Azure/GCP) provisioned through Terraform
* Microservices architecture
* Distributed ML processing
* Real-time streaming analytics

---

# Contribution

Contributions are welcome.
Steps:
1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to GitHub
5. Create a Pull Request

---

# Contact

Developer: MD Azhar Khan

Project: AI Global Business Growth Advisor

---
