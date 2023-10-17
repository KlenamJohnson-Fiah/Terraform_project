resource "aws_route_table" "route_outside" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"

  }

  tags = {
    Name = "route_table to 0.0.0.0/0 ips"
  }

}

resource "aws_route_table" "privsub1_to_privsub2" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  count  = length("${var.private_subnet_cidr_block_1}")


  route {
    cidr_block  = "${var.private_subnet_cidr_block_2[count.index]}"
    instance_id = "${aws_instance.apiend_instance[count.index].id}"
  }
  tags = {
    Name = format("route from Private_sub_2 to Private_sub_1 - %s", tostring(count.index))
  }

}

resource "aws_route_table" "privsub1_to_natgw" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  depends_on = [
    aws_nat_gateway.nat_gate
  ]

  count = length("${var.private_subnet_cidr_block_1}")

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gate[count.index].id}"
  }
  tags = {
    Name = format("route from Private_sub_1 to NAT - %s", tostring(count.index))
  }

}
resource "aws_route_table" "privsub2_to_natgw" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  depends_on = [
    aws_nat_gateway.nat_gate
  ]


  count = length("${var.private_subnet_cidr_block_1}")

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gate[count.index].id}"
  }
  tags = {
    Name = format("route from Private_sub_2 to NAT - %s", tostring(count.index))
  }

}


#+++++++++++++++++++++++++++++++++aws_route_table_association+++++++++++++++++++++++++++++++++++++++++++++


resource "aws_route_table_association" "publicsub_igw" {
  count = length("${var.public_subnet_cidr_block}")

  subnet_id      = "${aws_subnet.public_subnet[count.index].id}"
  route_table_id = "${aws_route_table.route_outside.id}"

}

resource "aws_route_table_association" "dmz_igw" {
  count = length("${var.dmz_subnet}")

  subnet_id      = "${aws_subnet.dmz[count.index].id}"
  route_table_id = "${aws_route_table.route_outside.id}"

}

resource "aws_route_table_association" "privatesub1_natgate" {
  count = length("${var.public_subnet_cidr_block}")

  subnet_id      = "${aws_subnet.private_subnet_1[count.index].id}"
  route_table_id = "${aws_route_table.privsub1_to_natgw[count.index].id}"

}
resource "aws_route_table_association" "privatesub2_natgate" {
  count = length("${var.public_subnet_cidr_block}")

  subnet_id      = "${aws_subnet.private_subnet_2[count.index].id}"
  route_table_id = "${aws_route_table.privsub2_to_natgw[count.index].id}"

}

