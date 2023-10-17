ips=""
ids=""
while [ "$ids" = "" ]; do
  ids=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG --region us-east-2 --query AutoScalingGroups[].Instances[].InstanceId --output text)
  sleep 1
done
for ID in $ids;
do
    IP=$(aws ec2 describe-instances --instance-ids $ID --region us-east-2 --query Reservations[].Instances[].PrivateIpAddress --output text)
    ips="$ips,$IP"
done