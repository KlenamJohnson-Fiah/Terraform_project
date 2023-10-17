resource "aws_autoscaling_group" "web_app_autoscale" {
  # for_each = toset(var.availability_zones)
  name     = "${aws_launch_configuration.launch_config.name}-asg"
  max_size = 5
  min_size = 1
  #availability_zones   = [each.value]    #"${var.availability_zones}"
  capacity_rebalance   = true
  desired_capacity     = 2
  health_check_type    = "ELB"
  load_balancers       = ["${aws_elb.web_elb.id}"]
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  vpc_zone_identifier  = "${aws_subnet.public_subnet[*].id}"

  
   enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupStandbyInstances"
  ]

  metrics_granularity = "1Minute"





  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }

}

