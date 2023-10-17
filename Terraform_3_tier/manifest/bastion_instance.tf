resource "aws_instance" "bastion_instance" {
  depends_on = [
    aws_subnet.dmz
  ]
 #count = length("${var.availability_zones}")
 count = length("${var.dmz_subnet}")

  ami = local.ami_filter
  #tfsec:ignore:AWS079
  #No need for an IMDS in this case
  instance_type          = "t2.micro"
  availability_zone      = "${var.availability_zones[count.index]}"
  key_name               = "bastion-key"
  subnet_id              = "${aws_subnet.dmz[count.index].id}"
  vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]

  tags = {
    Name = format("bastion_instance-%s", "${var.availability_zones[count.index]}")
  }


  connection {
    type        = "ssh"
    host        = "${self.public_ip}"
    user        = "ec2-user"
    private_key = var.BASTION_PRIVATE_KEY
    agent       = false
  }



  provisioner "file" {
    source      = "../access"
    destination = "/tmp/"


    connection {
      type        = "ssh"
      host        = "${self.public_ip}"
      user        = "ec2-user"
      private_key = var.BASTION_PRIVATE_KEY
      agent       = false
    }

  }


}
