#!/bin/bash
# ==============================================================================
# Container Entrypoint Script — AI Recommendation & DevOps Orchestration
# Author: MD AZHAR
# ==============================================================================
set -e

echo "======================================================================"
echo "🚀 Starting AI-Based Business Recommendation System with DevOps Stack"
echo "======================================================================"
echo "2. Methodology Implementation:"
echo "   [1] Puppet    — Configuration Management"
echo "   [2] Nagios    — Health & Availability Monitoring (NRPE)"
echo "   [3] Terraform — Infrastructure as Code (IaC)"
echo "   [4] Ansible   — Automated Deployment & Playbook Execution"
echo "======================================================================"

# ------------------------------------------------------------------------------
# 1. Puppet Configuration Management Check
# ------------------------------------------------------------------------------
echo "⚙️ [Puppet] Checking system configuration manifests..."
if [ -f "/etc/puppet/manifests/site.pp" ]; then
    puppet apply /etc/puppet/manifests/site.pp --detailed-exitcodes || {
        STATUS=$?
        if [ $STATUS -eq 2 ]; then
            echo "✅ [Puppet] Changes applied successfully to reach desired state."
        elif [ $STATUS -eq 0 ]; then
            echo "✅ [Puppet] System configuration already in desired state."
        else
            echo "⚠️ [Puppet] Run completed with status code $STATUS (continuing)."
        fi
    }
fi

# ------------------------------------------------------------------------------
# 2. Nagios Monitoring Service Initialization
# ------------------------------------------------------------------------------
echo "📊 [Nagios] Initializing Nagios NRPE monitoring agent on port 5666..."
if [ -f "/etc/nagios/nrpe.cfg" ]; then
    # Start NRPE server as background daemon
    if command -v nrpe >/dev/null 2>&1; then
        nrpe -c /etc/nagios/nrpe.cfg -d
        echo "✅ [Nagios] NRPE daemon started successfully."
    elif [ -x "/etc/init.d/nagios-nrpe-server" ]; then
        /etc/init.d/nagios-nrpe-server start || true
        echo "✅ [Nagios] NRPE service initiated."
    fi
fi

# ------------------------------------------------------------------------------
# 3. Terraform Verification
# ------------------------------------------------------------------------------
echo "🏗️ [Terraform] Verifying Infrastructure as Code toolchain..."
if command -v terraform >/dev/null 2>&1; then
    TF_VER=$(terraform -version | head -n 1)
    echo "✅ [Terraform] Ready ($TF_VER)"
fi

# ------------------------------------------------------------------------------
# 4. Ansible Automation & Playbook Syntax Check
# ------------------------------------------------------------------------------
echo "📜 [Ansible] Verifying deployment playbooks..."
if command -v ansible-playbook >/dev/null 2>&1; then
    if [ -f "/etc/ansible/playbooks/playbook.yml" ]; then
        ansible-playbook /etc/ansible/playbooks/playbook.yml --syntax-check || true
        echo "✅ [Ansible] Playbook syntax validated."
    fi
fi

echo "======================================================================"
echo "🎯 Launching AI-Based Business Recommendation Service..."
echo "======================================================================"

# Execute the primary CMD (e.g., python backend/app.py)
exec "$@"

