# resource "aws_network_acl" "main_acl" {
#   for_each = toset("${var.dmz_subnet}")

#   vpc_id     = "${aws_vpc.main_vpc.id}"
#   subnet_ids = "${aws_subnet.public_subnet[*].id}"
#   tags = {
#     Name = "${var.env_instance_tags}-acl_for_public_subnet"

#   }

#   #++++++++++++++++++++(ingress acl)+++++++++++++++++++++++++++++
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 22
#     to_port    = 22
#   }
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 433
#     to_port    = 433
#   }
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 400
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 8000
#     to_port    = 8000
#   }
#   # allow egress ephemeral ports
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 700
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }
#   ingress {
#     protocol   = "icmp"
#     rule_no    = 800
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#     icmp_type  = -1
#     icmp_code  = -1
#   }

#   #++++++++++++++++++++++++++++++(egress acl)++++++++++++++++++++++++++++
#   egress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 22
#     to_port    = 22
#   }
#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 433
#     to_port    = 433
#   }
#   egress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }
#   egress {
#     protocol   = "tcp"
#     rule_no    = 400
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 8000
#     to_port    = 8000
#   }
#   # allow egress ephemeral ports
#   egress {
#     protocol   = "tcp"
#     rule_no    = 700
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }
#   egress {
#     protocol   = "icmp"
#     rule_no    = 800
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#     icmp_type  = -1
#     icmp_code  = -1
#   }
# }







