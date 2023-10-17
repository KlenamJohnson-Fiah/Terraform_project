locals {
  instance_name = "${terraform.workspace}.instance"
}


resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = local.instance_name
  }

}    
