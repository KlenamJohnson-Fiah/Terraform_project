
resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "terraform-launch_config"
  image_id                    = local.ami_filter #data.aws_ami.linux.id
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.web_app.id}"]
  associate_public_ip_address = false
  key_name                    = "webapp-key"

#tfsec:ignore:AWS014
#Not neccessary to encrypt root EBS for this example
  user_data = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install docker -y
  sudo service docker start
  sudo usermod -a -G docker ec2-user
  echo "Hello, World" > index.html
  nohup busybox httpd -f -p 8080 &
  

  EOF
  #the docker image pull just and example obtained from
  #https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-pull-ecr-image.html
  #docker pull aws_account_id.dkr.ecr.us-east-2.amazonaws.com/amazonlinux:latest 

  lifecycle {
    create_before_destroy = true
  }
}
