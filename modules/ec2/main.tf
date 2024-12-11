data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["137112412989"] #Amazon

  filter {
    name   = "name"
    values = ["*al2023-ami-2023*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "server" {
  ami                         = data.aws_ami.server_ami.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.security_group_id
  subnet_id                   = var.subnet_id
  count                       = var.instance_count
  key_name                    = var.key_name
  iam_instance_profile        = var.instance_profile
  associate_public_ip_address = var.public_ip
  user_data                   = <<-EOF
       #!/bin/bash
       sudo su
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Terraform Provision Server Details</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>" >> /var/www/html/index.html
    EOF
  root_block_device {
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    delete_on_termination = var.delete_on_termination
    iops                  = var.ebs_iops
    throughput            = var.ebs_throughput
    tags = {
      "Name" = "root_ebs_vol"
    }
  }

  tags = merge(
    {
      Name = "${var.env_name}-${count.index + 2}"
    },
    var.ec2_tags
  )
}
