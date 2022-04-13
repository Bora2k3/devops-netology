output "yandex_zone" {
  value       = yandex_compute_instance.vm.zone
  description = "Yandex-zone in which the instance was created"
}

output "yandex_ip_private" {
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
  description = "Private IP on Yandex-cloud"
}

output "yandex_vpc_subnet" {
  value       = resource.yandex_vpc_subnet.subnet.id
  description = "Subnet ID where the instance was created"
}

output "aws_account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "AWS account ID"
}

output "aws_user_id" {
  value       = data.aws_caller_identity.current.user_id
  description = "AWS user ID"
}

output "aws_region" {
  value       = data.aws_region.current.endpoint
  description = "AWS region in use"
}

output "aws_net_private_ip" {
  value       = resource.aws_instance.ubuntu.private_ip
  description = "Private IP ec2 instance"
}

output "aws_net_subnet_id" {
  value       = resource.aws_instance.ubuntu.subnet_id
  description = "Subnet ID where the instance was created"
}