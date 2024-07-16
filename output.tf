output "arn" {
  value       = try(aws_iam_role.this.arn, "")
  description = "role arn"
}

output "name" {
  value       = try(aws_iam_role.this.name, "")
  description = "role name"
}

output "instance_profile_name" {
  value       = try(aws_iam_instance_profile.default[0].name, "")
  description = "Instance profile name"
}