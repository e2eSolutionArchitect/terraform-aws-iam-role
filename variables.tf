
variable "tags" {
  type        = map(string)
  description = "tags"
}

variable "role_name" {
  type        = string
  description = "role name"
}


variable "iam_policy_identifiers" {
  type        = list(string)
  description = "iam_policy_identifier"
}


variable "managed_policy_arns" {
  type        = set(string)
  description = "List of managed policy to attach to role"
}


variable "custom_policy_statements" {
  type        = list(string)
  description = "role name"
}


variable "add_custom_policy" {
  type        = bool
  description = "to create additional inline policy"
}


variable "custom_policy_name" {
  type        = string
  description = "Name of the custom policy"
}

variable "is_instance_profile_enabled" {
  type        = bool
  description = "Create EC2 instance profile for the role"
}

variable "instance_profile_name" {
  type        = string
  description = "EC2 instance profile name"
}