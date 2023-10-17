resource "aws_autoscaling_policy" "up_policy" {
  name                   = "webapp_up_policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = "${aws_autoscaling_group.web_app_autoscale.name}"
}


resource "aws_autoscaling_policy" "down_policy" {
  name                   = "webapp_down_policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = "${aws_autoscaling_group.web_app_autoscale.name}"
}
