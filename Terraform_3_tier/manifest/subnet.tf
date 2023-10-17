resource "aws_subnet" "public_subnet" {
  depends_on = [
    aws_vpc.main_vpc
  ]
  #count = length("${var.availability_zones}")
  count = length("${var.public_subnet_cidr_block}")
  

  vpc_id                  = "${aws_vpc.main_vpc.id}"
  availability_zone       = "${var.availability_zones[count.index]}"
  cidr_block              = "${var.public_subnet_cidr_block[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env_instance_tags}-Public-Subnet"

  }
}

resource "aws_subnet" "dmz" {
  depends_on = [
    aws_vpc.main_vpc
  ]
  #count = length("${var.availability_zones}")
  count = length("${var.dmz_subnet}")

  vpc_id                  = "${aws_vpc.main_vpc.id}"
  availability_zone       = "${var.availability_zones[count.index]}"
  cidr_block              = "${var.dmz_subnet[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env_instance_tags}-DMZ-subnet"
  }

}
resource "aws_subnet" "private_subnet_1" {
  depends_on = [
    aws_vpc.main_vpc
  ]
  #count = length("${var.availability_zones}")
  count = length("${var.private_subnet_cidr_block_1}")

  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = "${var.availability_zones[count.index]}"
  cidr_block        = "${var.private_subnet_cidr_block_1[count.index]}"
  tags = {
    Name = "${var.env_instance_tags}-Private-Subnet-1"

  }

}

resource "aws_subnet" "private_subnet_2" {
  depends_on = [
    aws_vpc.main_vpc
  ]
  #count = length("${var.availability_zones}")
  count = length("${var.private_subnet_cidr_block_2}")

  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = "${var.availability_zones[count.index]}"
  cidr_block        = "${var.private_subnet_cidr_block_2[count.index]}"
  tags = {
    Name = "${var.env_instance_tags}-Private-Subnet-2"

  }

}

resource "aws_db_subnet_group" "db_subnet_grp" {
  name = "db_subnet_group"
  subnet_ids = "${aws_subnet.private_subnet_2[*].id}"

  tags = {
    Name = "${var.env_instance_tags}-DB-subnet-grp"
  }
}

