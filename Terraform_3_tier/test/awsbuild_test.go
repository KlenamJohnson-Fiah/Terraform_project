package testing

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformVPC(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../manifest",

		VarFiles: []string{"../dev_env/dev.tfvars"},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	vpcId := terraform.Output(t, terraformOptions, "vpc")

	region := "us-east-2"

	aws.GetVpcById(t, vpcId, region) //confirm there's a VPC with the ID from my VPC output
	vpcSubnet := aws.GetSubnetsForVpc(t, vpcId, region)
	fmt.Printf("Subnets - %s\n", vpcSubnet)

	deployedPublicSubnets := terraform.OutputList(t, terraformOptions, "public_subnet")
	for _, s := range deployedPublicSubnets {
		assert.True(t, aws.IsPublicSubnet(t, s, region), "Not Public Subnet")
	}

	deployedPrivate1Subnets := terraform.OutputList(t, terraformOptions, "private_subnet_cidr_block_1")
	for _, s := range deployedPrivate1Subnets {
		assert.False(t, aws.IsPublicSubnet(t, s, region), "Not Private Subnet")
	}

	deployedPrivate2Subnets := terraform.OutputList(t, terraformOptions, "private_subnet_cidr_block_2")
	for _, s := range deployedPrivate2Subnets {
		assert.False(t, aws.IsPublicSubnet(t, s, region), "Not Private Subnet")
	}

	//----------Getting Private IPs of instances--------------
	bastion_instances := terraform.OutputList(t, terraformOptions, "bastion_instance")
	apiserver_instances := terraform.OutputList(t, terraformOptions, "apiserver_instance")

	bastion_print, _ := aws.GetPrivateIpsOfEc2InstancesE(t, bastion_instances, region)
	fmt.Printf("The Bastion Instance Private IPs are - %s", bastion_print)

	apiserver_print, _ := aws.GetPrivateIpsOfEc2InstancesE(t, apiserver_instances, region)
	fmt.Printf("The APIserver Instance Private IPs are - %s", apiserver_print)

	//-------DB Address and Port test-------------
	masterDB_id := terraform.OutputList(t, terraformOptions, "masterDB_instance_id")
	slaveDB_id := terraform.OutputMapOfObjects(t, terraformOptions, "slaveDB_instance_id")

	for _, db := range masterDB_id {
		masterDB_address := aws.GetAddressOfRdsInstance(t, db, region)
		fmt.Printf("Master DB address - %s\n", masterDB_address)
	}

	for _, v := range slaveDB_id {
		slaveDB_address := aws.GetAddressOfRdsInstance(t, v.(string), region)
		fmt.Printf("Slave DB address - %s\n", slaveDB_address)
	}

	for _, db := range masterDB_id {
		masterDB_port := aws.GetPortOfRdsInstance(t, db, region)
		fmt.Printf("Master DB port - %d\n", masterDB_port)
	}

	for _, v := range slaveDB_id {
		slaveDB_port := aws.GetPortOfRdsInstance(t, v.(string), region)
		fmt.Printf("Slave DB port - %d\n", slaveDB_port)
	}

}
