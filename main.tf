variable "name" { default = "ks-github-terraform-bot"}

variable "s3_bucket" { default = "ks-github-tf-aws"}
variable "lock_table" { default = "ks-github-tf-aws" }

variable "fqdn" { default = "bench3.usegvl.org" }

resource "aws_eip" "frontend" {
  instance = aws_instance.vm1.id
  vpc      = true
}

resource "aws_route53_record" "bench3" {
  zone_id = var.dns_zone
  name    = var.fqdn
  type    = "A"
  ttl     = "3600"
  records = [aws_eip.frontend.public_ip]
}

resource "aws_network_interface" "gateway" {
  subnet_id       = var.subnet
  security_groups = ["sg-01d3bb3198fb64c62"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "vm1" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = var.instance_type
  key_name      = var.key_name
  iam_instance_profile = aws_iam_instance_profile.profile.name
  root_block_device {
    volume_size = 250
  }

  network_interface {
    network_interface_id = aws_network_interface.gateway.id
    device_index         = 0
  }

  tags = {
    Name  = "BenchmarkDev"
    Owner = "ks"
  }
}


