variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string

  validation {
    condition     = can(regex("\\.", var.instance_type))
    error_message = "The name value must have at dot '.' in it."
  }
}


variable "security_group_id" {
  description = "The Security Group ID"
  type        = set(string)
}

variable "subnet_id" {
  description = "The public subnet ID"
  type        = string
}

variable "public_ip" {
  description = "associate_public_ip_address or not"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair for EC2 instances"
  type        = string

  validation {
    condition     = can(regex("\\-", var.key_name))
    error_message = "The name value must have at hypen '-' in it."
  }
}

variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "ec2_tags" {
  description = "A map of additional tags to apply to the instance."
  type        = map(string)
  default     = {}
}

variable "ebs_volume_size" {
  description = "The size of the EBS volume in GB."
  type        = number
}

variable "ebs_volume_type" {
  description = "The type of the root EBS volume (e.g., gp2, gp3, io1)"
  type        = string
}

variable "delete_on_termination" {
  description = "Automatically delete EBS volume when instance is terminated."
  type        = string
}

variable "ebs_iops" {
  description = "The number of IOPS to provision for the EBS volume. Only applicable for io1 and io2 volumes."
  type        = number
}

variable "ebs_throughput" {
  description = "The throughput in MiB/s to provision for the EBS volume. Only applicable for gp3 volumes."
  type        = number
}

# variable "kms_key_id" {
#   description = "kms key id"
#   type        = string
# }

variable "instance_count" {
  description = "The number of EC2 instances to launch "
  type        = number
}

variable "instance_profile" {
  description = "Name of the instance profile attach to ec2 instance(IAM) "
  type        = string
  default     = ""
}

