output "vpc" {
  value = "${aws_vpc.main_vpc.id}"
}

output "public_subnet" {
  value = "${aws_subnet.public_subnet[*].id}"

}

output "dmz" {
  value = "${aws_subnet.dmz[*].id}"

}

output "private_subnet_cidr_block_1" {
  value = "${aws_subnet.private_subnet_1[*].id}"

}

output "private_subnet_cidr_block_2" {
  value = "${aws_subnet.private_subnet_2[*].id}"

}

output "db_subnet_grp" {
  value = "${aws_db_subnet_group.db_subnet_grp.id}"

}


output "elb_ids" {
  value = "${aws_elb.web_elb[*].id}"
}

output "autoscaling_group" {
  value = {
    "autoscaling_ID"                = "${aws_autoscaling_group.web_app_autoscale.id}",
    "autoscaling_avaliablity_zones" = "${aws_autoscaling_group.web_app_autoscale[*].availability_zones}"

  }

}

output "autoscaling_policy" {
  value = {
    "autoscaling_policy_name-UP"       = "${aws_autoscaling_policy.up_policy.name}"
    "autoscaling_policy_group_name-UP" = "${aws_autoscaling_policy.up_policy.autoscaling_group_name}"

    "autoscaling_policy_name-DOWN"       = "${aws_autoscaling_policy.down_policy.name}"
    "autoscaling_policy_group_name-DOWN" = "${aws_autoscaling_policy.down_policy.autoscaling_group_name}"
  }

}


output "cloudwatch_metric_watch" {
  value = {
    "cloudwatch-UP-alarm"   = "${aws_cloudwatch_metric_alarm.up_alarm_watch.id}"
    "cloudwatch-DOWN-alarm" = "${aws_cloudwatch_metric_alarm.down_alarm_watch.id}"
  }

}

output "elb" {
  value = {
    "elb-id"                = "${aws_elb.web_elb.id}"
    "elb-name"              = "${aws_elb.web_elb.name}"
    "elb-dns_name"          = "${aws_elb.web_elb.dns_name}"
    "elb-list_of_instances" = "${aws_elb.web_elb.instances}"
  }
}


output "internet_gateway" {
  value = {
    "internet_gateway-id" = "${aws_internet_gateway.igw.id}"
  }

}


output "security_group" {
  value = {
    "web_app_security_group"          = "${aws_security_group.web_app.id}"
    "private_subnet_1_security_group" = "${aws_security_group.private_subnet_1.id}"
    "private_subnet_2_security_group" = "${aws_security_group.private_subnet_2.id}"
    "load_balancer_security_group"    = "${aws_security_group.load_balancer.id}"
  }
}


output "apiserver_instance" {
  value = "${aws_instance.apiend_instance[*].id}"
}

output "bastion_instance" {
  value = "${aws_instance.bastion_instance[*].id}"
}

output "bastion_instance_ip"{
  value = "${aws_instance.bastion_instance[*].public_ip}"
}

output "bastion_instance_pubdns"{
  value = "${aws_instance.bastion_instance[*].public_dns}"
}

output "bastion_instance_key_name" {
  value = "${aws_instance.bastion_instance[*].key_name}"
}


output "masterDB_instance_id" {
  value = "${aws_db_instance.master_db_instance[*].id}"
  
}
output "masterDB_instance_name" {
  value = "${aws_db_instance.master_db_instance[*].name}"
  
}
output "slaveDB_instance_id" {
  value = {for slave in aws_db_instance.slave_db_instance: slave.id => slave.id }
  
}

output "slaveDB_instance_name" {
  value = {for slave in aws_db_instance.slave_db_instance: slave.name => slave.name}
  
}


# output "acl" {
#   value = {
#     "main_acl" = { for acl in aws_network_acl.main_acl : acl.id => acl.id}
#   }
# }


output "eip" {
  value = {
    "nat_gate_eip"     = "${aws_eip.nat_gate[*].id}"

  }
}

output "nat_gateway" {
  value = "${aws_nat_gateway.nat_gate[*].id}"
}

output "route_table" {
  value = {
    "route_outside"        = "${aws_route_table.route_outside.id}"
    "dmz_to_igw"           = "${aws_route_table_association.dmz_igw[*].id}"
    "privsub1_to_natgw"    = "${aws_route_table.privsub1_to_natgw[*].id}"
    "privsub2_to_natgw"    = "${aws_route_table.privsub2_to_natgw[*].id}"
  }
}


