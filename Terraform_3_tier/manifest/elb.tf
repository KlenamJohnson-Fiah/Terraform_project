resource "aws_elb" "web_elb" {
  name            = "web-elb"
  security_groups = ["${aws_security_group.load_balancer.id}"]
  subnets                   = "${aws_subnet.public_subnet[*].id}"
  cross_zone_load_balancing = true
  internal                  = false #tfsec:ignore:AWS005
  #availability_zones        = "${var.availability_zones}"

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"

  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 3

  }


}

#Should probably use aws_lb and aws_lb_listener next time. 
#That way i can attach and EIP to my load balancer
