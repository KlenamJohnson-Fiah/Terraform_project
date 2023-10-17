data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

locals {
  ami_filter = "${data.aws_ami.linux.id}"
}

locals {
  slave_db = setsubtract("${var.availability_zones}",slice(var.availability_zones,0,1))
}