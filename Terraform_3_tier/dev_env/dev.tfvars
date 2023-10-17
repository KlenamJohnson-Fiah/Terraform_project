region = "us-east-2"   

env_instance_tags = "DEV"

availability_zones = ["us-east-2a", "us-east-2b"] 

public_subnet_cidr_block = ["10.0.2.0/24"] #["10.0.2.0/24", "10.0.4.0/24"] 

dmz_subnet = ["10.0.21.0/24"] #["10.0.21.0/24", "10.0.22.0/24"] 

private_subnet_cidr_block_1 = ["10.0.3.0/24"] #["10.0.3.0/24", "10.0.5.0/24"]  

private_subnet_cidr_block_2 =  ["10.0.7.0/24", "10.0.9.0/24"] 

#ssh_public_key_bastion = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAuOA224K7E0C3+I+9IlpYA1hPCXEICp7mp3/3Tvmm2YgH5qPO/F4OSrmSHNoSRIqO/mXBhTH9QkPcOFXeiwBfSHyzfPz0pO5quQPPo6Ja7sC7xEdXC+l1wa1Izq2wkcab1cFEpT8+JQ09vF4cTJTdhP2VwQCzdY0wNlRFzCHJwcdwRnemAhSe5uKDdVV3yAa2F6afdEsib4GWAZVzRpab7lcu4kUHCZ9MQYTOCRLdz1nhC42rkJ+HP7cifqWOqWH1hxNvPxzgX9acvJKKmFSWjCD4MXSeQZYyFNE8gBj9c7/mDeMATtgxAxnW9Jxp7VX4Vx9qJVloOdMfTuQa+gf12Q== rsa-key-20210405"

#ssh_public_key_apiend = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAixPJR2/nykTsLnMxsF6kVv+FvGXkYamJ7hYJ/RII3h3QDJ5HDQ56eay5EuazskEYl5EJJ3ASDyQNe5G6oOAmkGfcOvUfK+Nrzb3wLYhtX707umJLoRGp0J7washwVaISvuFi1rDXbNDjTWHmOMkKhnsxN4Fmsu1psyewg1KubMLjKhbwIeQVgsz/rjOMh7y+z+DK/PJTsSC1YH8sEjCOxmF4pWdIkSApjYHNEGTiB9mL+ZhI2KNfo4SWODP1DQ8gos38/1HGdW0Qrc9+msdulP1KqGsQT4v07x0+4LcfEKt+gEdVWmIZ1lq9TJDf/GjR949/qwidXmttWSNbhHje8w== rsa-key-20210405"

#ssh_public_key_database = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAp8eAt0H1OcIX1hht/Neb5tBFvhvaJiQQl/w7q8RTzb213IapeFUBcAQvFH+NcQFlSKxEa9e5d8wSCsg9kecMS1adDYYCHMROnes6oRrpjny2vda1903qiqdga6DYfe4VNDf3NihX9Cho/3dtmMRazZ8/eTqKcmDB/vPFDSmBhRu34cjkRhgdVA1Glt8Vu7Yqs0fDFTB/FbcqolXlygtxpAy3L7VYDulxmboseaDsrI90bfH10IdOpDriQdphG3bCf2fy4LP/ze5lKgRwvd3+ZSggz31Dzcp9/H9s8IOTZnVw89UIa+VZe/M+1EJxJsV4jReuS+Myf4RUMhzdt7KG3Q== rsa-key-20210405"

#ssh_public_key_webapp = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAjR/t+jC4Oi0ufR/86jucNRpiudYyvhSg2JukWWxV0PUBeEjghSKzrcSiY0pz22Vuu+WLCPdVWwKqGJvHK7Bts5/DyC2SzCliAXEHTCztl3TuLHkWPoC/IULwpSs57UQRqFP3WtL68T4mx/+FjOf0gT7Lckk4mNNMDnZ8xiEdy8KjITg471jC//rDnSe/JcdgHzbjW/3i1zRbk8QV1F7THilQfaMJz43dBK0EKB56nxKfVUHljEJxAgpVpvMMTJBqFuHkUm3BgzFp1PDg8GFRlRIWIJYbGOccgkEGFnOKz2tLL1dSwydMHObPWXbsBFVk3mCe4NG7ezx/8XF+zkwchw== rsa-key-20210405"

db_username = "postgres"

db_password = "postgres"

