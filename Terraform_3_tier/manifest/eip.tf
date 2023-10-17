resource "aws_eip" "nat_gate" {
  #count = length(var.availability_zones)
  count = length(var.public_subnet_cidr_block)
  #instance = "${aws_nat_gateway.web_elb.id}"
  vpc = true

}

resource "aws_eip" "dmz" {
  count    = length(var.dmz_subnet)
  instance = "${aws_instance.bastion_instance[count.index].id}"

}
