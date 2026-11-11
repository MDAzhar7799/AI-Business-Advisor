# ==============================================================================
# AI-Based Business Recommendation System — Dockerfile
# Integrated with DevOps Methodology: Puppet, Nagios, Terraform, Ansible
# Author: MD AZHAR
# ==============================================================================
#
# 2. Methodology Architecture:
# -----------------------------
# 1. Puppet    - Configuration Management: Automates server configuration,
#                maintains cross-server consistency, ensures desired state.
# 2. Nagios    - Monitoring: Monitors CPU, memory, disk, and application
#                availability, raising alerts if monitored services fail.
# 3. Terraform - Infrastructure as Code: Automates infrastructure provisioning,
#                manages cloud VMs, VPCs, and networking.
# 4. Ansible   - Automation & Deployment: Playbook-based deployment and setup,
#                reducing manual intervention.
#
# ==============================================================================

FROM python:3.10-slim

LABEL maintainer="MD AZHAR"
LABEL project="AI Global Business Growth Advisor & DevOps Pipeline"
LABEL version="2.0"
LABEL methodology="AI Recommendation + Puppet + Nagios + Terraform + Ansible"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    TERRAFORM_VERSION=1.6.6 \
    APP_HOME=/app \
    PUPPET_HOME=/etc/puppet \
    NAGIOS_HOME=/etc/nagios \
    ANSIBLE_HOME=/etc/ansible \
    TERRAFORM_HOME=/opt/terraform

# ------------------------------------------------------------------------------
# STEP 1: Install System Prerequisites & Core Utilities
# ------------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    unzip \
    gnupg \
    software-properties-common \
    git \
    procps \
    net-tools \
    iputils-ping \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# STEP 2: DevOps Tool 1 — Puppet (Configuration Management)
# ------------------------------------------------------------------------------
# Automates server configuration, installs software packages, and ensures
# required services and configurations remain in their desired state.
RUN apt-get update && apt-get install -y --no-install-recommends \
    puppet \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p ${PUPPET_HOME}/manifests ${PUPPET_HOME}/modules

# ------------------------------------------------------------------------------
# STEP 3: DevOps Tool 2 — Nagios (Monitoring & Alerting)
# ------------------------------------------------------------------------------
# Monitors server health (CPU, memory, disk usage) and application availability.
# Includes Nagios plugins and NRPE (Nagios Remote Plugin Executor).
RUN apt-get update && apt-get install -y --no-install-recommends \
    nagios-nrpe-server \
    monitoring-plugins \
    monitoring-plugins-basic \
    monitoring-plugins-standard \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/nagios ${NAGIOS_HOME}/plugins

# ------------------------------------------------------------------------------
# STEP 4: DevOps Tool 3 — Terraform (Infrastructure as Code)
# ------------------------------------------------------------------------------
# Automates infrastructure provisioning across cloud providers (VMs, networking).
RUN mkdir -p ${TERRAFORM_HOME} \
    && wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /usr/local/bin/ \
    && rm -f /tmp/terraform.zip \
    && terraform -version

# ------------------------------------------------------------------------------
# STEP 5: DevOps Tool 4 — Ansible (Automation and Deployment)
# ------------------------------------------------------------------------------
# Automates server setup, package configuration, and app deployment via playbooks.
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir \
        ansible \
        ansible-core \
    && mkdir -p ${ANSIBLE_HOME}/playbooks

# ------------------------------------------------------------------------------
# STEP 6: AI-Based Business Recommendation Engine Dependencies
# ------------------------------------------------------------------------------
WORKDIR ${APP_HOME}

# Copy python dependencies
COPY requirements.txt .

# Install application and ML dependencies
RUN pip install --no-cache-dir -r requirements.txt || \
    pip install --no-cache-dir \
        flask \
        flask-cors \
        flask-jwt-extended \
        python-dotenv \
        scikit-learn \
        pandas \
        numpy \
        requests \
        joblib

# ------------------------------------------------------------------------------
# STEP 7: Copy Application Source & DevOps Configurations
# ------------------------------------------------------------------------------
# Copy full codebase
COPY . ${APP_HOME}/

# Copy DevOps tool configuration assets
COPY docker/puppet/ ${PUPPET_HOME}/manifests/
COPY docker/nagios/nrpe.cfg ${NAGIOS_HOME}/nrpe.cfg
COPY docker/nagios/check_ai_service.sh /usr/lib/nagios/plugins/check_ai_service.sh
COPY docker/terraform/ ${TERRAFORM_HOME}/
COPY docker/ansible/ ${ANSIBLE_HOME}/playbooks/

# Ensure monitoring plugin and entrypoint script are executable
RUN chmod +x /usr/lib/nagios/plugins/check_ai_service.sh || true \
    && chmod +x ${APP_HOME}/docker/docker-entrypoint.sh || true

# ------------------------------------------------------------------------------
# STEP 8: Network Ports & Health Check
# ------------------------------------------------------------------------------
# Port 5000: AI Business Recommendation API Server (Flask)
# Port 80: Web Dashboard
# Port 5666: Nagios NRPE Monitoring Agent
EXPOSE 5000 80 5666

# Health check using Nagios check_http plugin to monitor application health
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD /usr/lib/nagios/plugins/check_http -H localhost -p 5000 -u /health || \
      curl --fail http://localhost:5000/ || exit 1

# ------------------------------------------------------------------------------
# STEP 9: Container Entrypoint & Startup
# ------------------------------------------------------------------------------
ENTRYPOINT ["/bin/bash", "/app/docker/docker-entrypoint.sh"]
CMD ["python", "backend/app.py"]
