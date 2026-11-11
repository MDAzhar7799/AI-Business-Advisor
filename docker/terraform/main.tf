# ==============================================================================
# Terraform Main Configuration — main.tf
# Methodology: Tool 3. Terraform — Infrastructure as Code (IaC)
# Author: MD AZHAR
# Description: Automates infrastructure provisioning, creates and manages cloud
#              resources (Virtual Machines, VPCs, Security Groups, Subnets).
# ==============================================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Virtual Private Cloud (VPC)
resource "aws_vpc" "ai_business_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "ai-business-guider-vpc"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

# 2. Public Subnet for Application
resource "aws_subnet" "ai_business_subnet" {
  vpc_id                  = aws_vpc.ai_business_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name      = "ai-business-guider-subnet"
    ManagedBy = "Terraform"
  }
}

# 3. Internet Gateway
resource "aws_internet_gateway" "ai_business_igw" {
  vpc_id = aws_vpc.ai_business_vpc.id

  tags = {
    Name = "ai-business-guider-igw"
  }
}

# 4. Route Table
resource "aws_route_table" "ai_business_rt" {
  vpc_id = aws_vpc.ai_business_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ai_business_igw.id
  }

  tags = {
    Name = "ai-business-guider-rt"
  }
}

resource "aws_route_table_association" "ai_business_rta" {
  subnet_id      = aws_subnet.ai_business_subnet.id
  route_table_id = aws_route_table.ai_business_rt.id
}

# 5. Security Group for AI Backend (Port 5000), Web (Port 80), and Nagios NRPE (Port 5666)
resource "aws_security_group" "ai_business_sg" {
  name        = "ai-business-security-group"
  description = "Security rules for AI Business Guider & DevOps services"
  vpc_id      = aws_vpc.ai_business_vpc.id

  # HTTP Web Traffic
  ingress {
    description = "HTTP Web Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Flask AI Recommendation API
  ingress {
    description = "Flask AI Backend API"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Nagios NRPE Monitoring Agent
  ingress {
    description = "Nagios NRPE Monitoring"
    from_port   = 5666
    to_port     = 5666
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # SSH for Ansible & Puppet automation
  ingress {
    description = "SSH Automation Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Internet Access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "ai-business-sg"
    ManagedBy = "Terraform"
  }
}

# 6. Virtual Machine (EC2 Instance) Hosting AI Business Guider
resource "aws_instance" "ai_recommendation_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.ai_business_subnet.id
  vpc_security_group_ids = [aws_security_group.ai_business_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io docker-compose git
              systemctl enable --now docker
              EOF

  tags = {
    Name        = "ai-business-recommendation-server"
    Role        = "AppServer-and-Monitoring"
    ManagedBy   = "Terraform"
    Environment = "production"
  }
}

