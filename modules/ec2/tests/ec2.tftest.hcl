##################################################
# Global varaibles
################################################## 
variables {
  # instance_type         = "t2.micro"
  # key_name              = "hulk-aws-keys"
  # delete_on_termination = true
  # env_name = "devops-application"
  instance_count    = 1
  kms_key_id        = "abc"
  public_ip         = true
  subnet_id         = "subnet-e6c8b6ab"
  security_group_id = ["sg-0f0f2d33ee008bc91"]
  # ec2_tags = {
  #   Environment = "dev"
  #   Owner       = "devops"
  #   Provision   = "Terraform"
  # }
  # #EC2 root EBS
  # ebs_volume_size = 8
  # ebs_volume_type = "gp3"
  # ebs_iops        = 3000
  # ebs_throughput  = 125
}

##################################################
# input validation
##################################################
run "validate_inputs" {
  command = plan

  variables {
    instance_type = "t2micro"
  }

  expect_failures = [
    var.instance_type
  ]
}

##################################################
# unit testing
##################################################
run "instance_name_validation" {
  command = plan

  assert {
    condition     = aws_instance.server[0].tags["Name"] == var.env_name
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}

# Verify created ec2 environment
run "environment_validation" {
  command = plan

  assert {
    condition     = aws_instance.server[0].tags["Environment"] == "dev"
    error_message = "TEST_ERROR: Instance Environment is not as expected"
  }
}

# Verify created ec2 key pair
run "lookup_verify_key_pair" {
  command = plan

  assert {
    condition     = aws_instance.server[0].key_name == var.key_name
    error_message = "Key pair name is wrong"
  }
}

# Verify created subnet_id
run "lookup_verify_subnet_id" {
  command = plan

  assert {
    condition     = aws_instance.server[0].subnet_id == var.subnet_id
    error_message = "Subnet is wrong"
  }
}
