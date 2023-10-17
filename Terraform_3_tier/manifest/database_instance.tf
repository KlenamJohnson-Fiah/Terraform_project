resource "aws_db_instance" "master_db_instance" {
  count = length(slice("${var.availability_zones}",0,1))

  allocated_storage   = 10
  engine              = "postgres"
  engine_version      = "12"
  instance_class      = "db.t2.micro"
  username            = "${var.db_username}"
  password            = "${var.db_password}"
  skip_final_snapshot = true

  #db.t2.micro does not support encryption at rest
  storage_encrypted      = false #tfsec:ignore:AWS052
  identifier             = format("master-db-in-%s", "${var.availability_zones[count.index]}")
  port                   = "5432"
  publicly_accessible    = false
  vpc_security_group_ids = "${aws_security_group.private_subnet_2[*].id}"
  db_subnet_group_name   = "${aws_db_subnet_group.db_subnet_grp.id}"
  #multi_az               = true
  availability_zone      = "${var.availability_zones[count.index]}"
  backup_retention_period = 3


}

resource "aws_db_instance" "slave_db_instance" {
    depends_on = [
      aws_db_instance.master_db_instance
    ]
  for_each = toset("${local.slave_db}")#length(setsubtract("${var.availability_zones}",slice(var.availability_zones,0,1)))

  allocated_storage = 10

  engine              = "postgres"
  engine_version      = "12"
  instance_class      = "db.t2.micro"
  username            = "${var.db_username}"
  #password            = "${var.db_password}"
  skip_final_snapshot = true
  #db.t2.micro does not support encryption at rest
  storage_encrypted      = false #tfsec:ignore:AWS052
  identifier             = format("slave-db-in-%s", "${each.value}")
  port                   = "5432"
  publicly_accessible    = false
  vpc_security_group_ids = "${aws_security_group.private_subnet_2[*].id}"
  db_subnet_group_name   = "${aws_db_subnet_group.db_subnet_grp.id}"
  #multi_az               = true
  availability_zone      = each.value
  replicate_source_db    = "${aws_db_instance.master_db_instance[0].arn}" #format("master-db-in-%s", "${var.availability_zones[0]}")

}
