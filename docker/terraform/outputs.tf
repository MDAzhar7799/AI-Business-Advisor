# ==============================================================================
# Terraform Outputs — outputs.tf
# Author: MD AZHAR
# ==============================================================================

output "vpc_id" {
  description = "ID of created VPC"
  value       = aws_vpc.ai_business_vpc.id
}

output "server_public_ip" {
  description = "Public IP address of AI Recommendation server"
  value       = aws_instance.ai_recommendation_server.public_ip
}

output "application_endpoint" {
  description = "URL endpoint for AI Business Guider API"
  value       = "http://${aws_instance.ai_recommendation_server.public_ip}:5000"
}

output "nagios_nrpe_endpoint" {
  description = "Nagios NRPE monitoring endpoint"
  value       = "${aws_instance.ai_recommendation_server.public_ip}:5666"
}

