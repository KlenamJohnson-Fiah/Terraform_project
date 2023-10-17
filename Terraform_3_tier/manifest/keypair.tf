# resource "aws_key_pair" "ssh_public_key_bastion" {
#   key_name   = "bastion-key"
#   public_key = var.ssh_public_key_bastion
# }


# resource "aws_key_pair" "ssh_public_key_apiend" {
#   key_name   = "apiend-key"
#   public_key = var.ssh_public_key_apiend
# }

# resource "aws_key_pair" "ssh_public_key_database" {
#   key_name   = "database-key"
#   public_key = var.ssh_public_key_database
# }

# resource "aws_key_pair" "ssh_public_key_webapp" {
#   key_name   = "webapp-key"
#   public_key = var.ssh_public_key_webapp
# }


#You could use this file to have terraform create the keypair values for you
#I did this manually for some funny reason :)