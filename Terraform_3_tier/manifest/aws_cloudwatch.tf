resource "aws_cloudwatch_metric_alarm" "up_alarm_watch" {
  alarm_name          = "Alarm to monitor up scaling"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web_app_autoscale.name}"
  }
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.up_policy.arn]

}

resource "aws_cloudwatch_metric_alarm" "down_alarm_watch" {
  alarm_name          = "Alarm to monitor down scaling"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web_app_autoscale.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.down_policy.arn]

}
