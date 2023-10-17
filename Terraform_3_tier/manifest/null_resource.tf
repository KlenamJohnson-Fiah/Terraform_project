# resource "null_resource" "provision_bastion" {
#     count = length(var.dmz_subnet)

#     connection {
#     type = "ssh"
#     host = "${aws_instance.bastion_instance[count.index].public_ip}"
#     user = "ec2-user"
#     private_key = "${file("C:/Users/Chris/Desktop/access/bastion")}"
#     agent = false
#   }



#     provisioner "file" {
#     source = "C:/Users/Chris/Desktop/access"
#     destination = "/tmp/"


#     connection {
#     type = "ssh"
#     host = "${aws_instance.bastion_instance[count.index].public_ip}"
#     user = "ec2-user"
#     private_key = "${file("C:/Users/Chris/Desktop/access/bastion")}"
#     agent = false
#   }
  
#     }
  
# }

#Not neccessary. Just in here to fulfill a need that never came