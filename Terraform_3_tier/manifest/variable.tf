# Used Environment Variables to provide my aws_access_key and aws_secret_key 
#in my CI/CD pipeline

# variable "aws_access_key" {
#   type = string
#   #sensitive = true
# }

# variable "aws_secret_key" {
#   type = string
#   #sensitive = true
# }

variable "region" {
  type = string
}

variable "env_instance_tags" {
    type = string
  
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidr_block" {
  type = list(string)
}

variable "private_subnet_cidr_block_1" {
  type = list(string)
}

variable "private_subnet_cidr_block_2" {
  type = list(string)
}

variable "dmz_subnet" {
  type = list(string)
  #default = ["172.27.20.0/24"]
}

# variable "ssh_public_key_bastion" {
#     type = string
#     description = "SSH publick key for Bastion server"
  
# }

# variable "ssh_public_key_apiend" {
#     type = string
#     description = "SSH publick key for API server"
  
# }

# variable "ssh_public_key_database" {
#     type = string
#     description = "SSH publick key  for Database server"
  
# }

  
# variable "ssh_public_key_webapp" {
#     type = string
#     description = "SSH publick key for Webapp server"
  
# }

variable "db_username" {
    type = string
    #sensitive = true
  
}

variable "db_password" {
    type = string
    #sensitive = true
  
}

variable "BASTION_PRIVATE_KEY" {
    type = string

}
