resource "aws_nat_gateway" "nat_gate" {
  depends_on = [
    aws_internet_gateway.igw
  ]
  count = length("${var.public_subnet_cidr_block}")

  allocation_id = "${aws_eip.nat_gate[count.index].id}"
  subnet_id     = "${aws_subnet.public_subnet[count.index].id}"

}



