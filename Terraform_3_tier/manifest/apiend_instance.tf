resource "aws_instance" "apiend_instance" {
  depends_on = [
    aws_subnet.dmz
  ]
  #count = length("${var.availability_zones}")
  count = length("${var.private_subnet_cidr_block_1}")

  ami                    = local.ami_filter
  #tfsec:ignore:AWS079
  #No need for an IMDS in this case
  instance_type          = "t2.micro" 
  availability_zone      = "${var.availability_zones[count.index]}"
  key_name               = "apiend-key"
  subnet_id              = "${aws_subnet.private_subnet_1[count.index].id}"
  vpc_security_group_ids = ["${aws_security_group.private_subnet_1.id}"]

  tags = {
    Name = format("apiend_instance-%s", "${var.availability_zones[count.index]}")
  }

}


