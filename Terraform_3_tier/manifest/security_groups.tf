resource "aws_security_group" "web_app" {
  name        = "Security group for the web_app"
  description = "Rules on what to allow in or out"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    description = "https"
    from_port   = 433
    protocol    = "tcp"
    to_port     = 433

  }
  ingress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1

  }
  ingress {
    cidr_blocks = "${var.dmz_subnet}" 
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80

  }

  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    description = "HTTPS"       # IT make it more secure i could create a new subnet,  
    from_port   = 433           # put load balancer in there and allow only that specific CIDR
    protocol    = "tcp"
    to_port     = 433

  }
  egress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1

  }
  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80

  }
  egress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

}


resource "aws_security_group" "private_subnet_1" {

  name        = "Security group instances in the private subnet 1"
  description = "Rules on what to allow in or out"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
  ingress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = "${var.public_subnet_cidr_block}"
    description = "Communication to openapi page"
    from_port   = 8000
    protocol    = "tcp"
    to_port     = 8000
  }
  ingress {
    cidr_blocks = "${var.private_subnet_cidr_block_2}"
    description = "Communication to DB"
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }



  egress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
  egress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  egress {
    cidr_blocks = "${var.public_subnet_cidr_block}"
    description = "Communication to openapi page"
    from_port   = 8000
    protocol    = "tcp"
    to_port     = 8000
  }
  egress {
    cidr_blocks = "${var.private_subnet_cidr_block_2}"
    description = "Communication to DB"
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }

}


resource "aws_security_group" "private_subnet_2" {

  name        = "Security group instances in the private subnet 2"
  description = "Rules on what to allow in or out"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
  ingress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "Communication to openapi page"
    from_port   = 8000
    protocol    = "tcp"
    to_port     = 8000
  }
  ingress {
    cidr_blocks = "${var.private_subnet_cidr_block_1}"
    description = "Communication to DB"
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }



  egress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
  egress {
    cidr_blocks = "${var.dmz_subnet}"
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  egress {
    cidr_blocks = "${var.private_subnet_cidr_block_1}"
    description = "Communication to DB"
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }

}


resource "aws_security_group" "load_balancer" {
  name        = "Security group for the Load Balancer"
  description = "Rules on what to allow in or out"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    description = "https"
    from_port   = 433
    protocol    = "tcp"
    to_port     = 433
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = "${var.dmz_subnet}" #tfsec:ignore:AWS008
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }



  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    description = "https"
    from_port   = 433
    protocol    = "tcp"
    to_port     = 433
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  egress {
    cidr_blocks = "${var.dmz_subnet}" #tfsec:ignore:AWS009
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "Security group instances ifor bastion"
  description = "Rules on what to allow in or out"
  vpc_id      = aws_vpc.main_vpc.id

# For security reasons would change this to some other port to avoid port 
#sniffing by hackers and most brute forcing scripts only try to connect to TCP port #22
  ingress {
    cidr_blocks = concat(["0.0.0.0/0"], "${var.dmz_subnet}", "${var.public_subnet_cidr_block}", "${var.private_subnet_cidr_block_1}",
    "${var.private_subnet_cidr_block_2}")
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
    description = "HTTP"
    from_port   = 433
    protocol    = "tcp"
    to_port     = 433
  }
  ingress {
    cidr_blocks = concat(["0.0.0.0/0"], "${var.dmz_subnet}", "${var.public_subnet_cidr_block}", "${var.private_subnet_cidr_block_1}",
    "${var.private_subnet_cidr_block_2}")
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }

  egress {
    cidr_blocks = concat(["0.0.0.0/0"], "${var.dmz_subnet}", "${var.public_subnet_cidr_block}", "${var.private_subnet_cidr_block_1}",
    "${var.private_subnet_cidr_block_2}")
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    description = "HTTP"
    from_port   = 433
    protocol    = "tcp"
    to_port     = 433
  }
  egress {
    cidr_blocks = concat(["0.0.0.0/0"], "${var.dmz_subnet}", "${var.public_subnet_cidr_block}", "${var.private_subnet_cidr_block_1}",
    "${var.private_subnet_cidr_block_2}")
    description = "PING"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
  egress {

    from_port   = 0 # can connect outbound on any port
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009

  }
}






