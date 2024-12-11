terraform {
  required_version = ">=1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.60.0"
    }
  }
}

module "mtr_bastion_instance" {
  source                = "./modules/ec2"
  instance_type         = "t2.micro"
  security_group_id     = ["<your-security-group-id>"]
  subnet_id             = "<subnet-id-here>"
  instance_count        = 1
  key_name              = "hulk-aws-keys"
  public_ip             = true
  ebs_volume_size       = 30
  ebs_volume_type       = "gp3"
  ebs_iops              = 3000
  ebs_throughput        = 125
  delete_on_termination = true
  env_name              = "devops"
  ec2_tags = {
    Resource = "ec2"
  }
  instance_profile = ""
}