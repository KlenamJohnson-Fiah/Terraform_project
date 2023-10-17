## Terraform infrastructure` using workspaces and Terratest in a GitHub actions CI/CD pipeline


This project involves building an infrastructure in AWS using the tools provided by Hashicorps Terraform.

The project contains a three-tier infrastructure in two availability zones. An instance for the front end that autoscales based on set perimeters. These instances that are deployed by autoscaling are monitored by AWS cloud watch `aws_cloudwatch.tf`.

The first tier contains an internet-facing elastic load balancer that distributes the workload between instances between the resources that span up from the `launch_config.tf `template. This could be your typical web app. 

The second tier contains instances that handle our REST API routing.`apiend_instance.tf`

The third tier contains a Postgres Database. The example makes sure there is only one master database and all other databases in other availability zones are read replicas. A general assumption here is, that in a list of AZs provided the first item is made the master databases.
```
Example: availability_zones = ["us-east-2a", "us-east-2b"] 

"us-east-2a is made the master DB and "us-east-2b" is made the replica.
```

This project was implemented using Terraform workspace hence we have two `.tfvars`files for the DEV env(`dev_env`) and QA env(`qa_env`)

Another couple of assumptions made:
1. In every creation we are going to have a Replica DB with requires us to have:
    1. At least two `availability_zones`
    2. At least two `private_subnet_cidr_block_2`
---

#### How to deploy
You could go ahead and deploy them to AWS.
 1. Set up by downloading Terraform and AWS CLI
 1. You will need to make sure you have Kepairs set for all instances. You could do this by including the `keypair.tf` file in the build(uncommenting the file) and assigning the key name to the `bastion_instance.tf`, `apiend_instance.tf`, `launch_config.tf`. OR you could manually create these keypairs in aws and assign the keypair names to the instances.
 2. You will need to set up the environment variable for the SSH Key for the bastion instance. 
 3. Run 
    1. `terraform init`
    2. `terraform plan -var-file=<TFVARS file path> (could use ../dev_env/dev.tfvars OR ../qa_env/qa.tfvars)`
    3. `terraform apply`

### Testing the Infrastructure with Terraform
You can test the infrastructure by running files present in the `test` folder.
___

#### How to run Terratest.
You need to have GOLANG installed.
Change directory to test folder
Run `go test run -v -timeout 30m awsbuild_test.go`
    - you can find out the definitions of the flags from [terratest](https://terratest.gruntwork.io/docs/getting-started/quick-start/)

Note: currently you can only run the `awsbuild_test.go` file to success. The `awsssh_test.go` gives an i/o timeout error when testing.

```
TestTerraformSSH 2021-05-09T21:36:09Z retry.go:103: SSH to public host ec2-18-191-38-21.us-east-2.compute.amazonaws.com returned an error: dial tcp 18.191.38.21:22: i/o timeout.
```
I can SSH into an instance from a local PC and terraform remote exec provisions instance with no problem. Still trying to figure out why. 
##### TODO: Fix the ssh challenge with Terratest.
