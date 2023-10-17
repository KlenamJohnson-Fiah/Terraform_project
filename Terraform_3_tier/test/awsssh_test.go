package testing

import (
	//"errors"
	//"crypto/x509"
	//"encoding/pem"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	//cryptossh "golang.org/x/crypto/ssh"
	//"io/ioutil"
	"os"
	"testing"
	"time"
)

// func RSAKeyPairFromFile(fpath string) (*ssh.KeyPair, error) {
// 	pemBytes, err := ioutil.ReadFile(fpath)
// 	if err != nil {
// 		return nil, err
// 	}
// 	pemBlock, _ := pem.Decode(pemBytes)
// 	if pemBlock == nil {
// 		return nil, fmt.Errorf("failedd to decode PEM block containing private key")
// 	}
// 	privKey, err := x509.ParsePKCS1PrivateKey(pemBlock.Bytes)
// 	if err != nil {
// 		return nil, err
// 	}
// 	sshPubKey, err := cryptossh.NewPublicKey(privKey.Public())
// 	if err != nil {
// 		return nil, err
// 	}
// 	sshPubKeyBytes := cryptossh.MarshalAuthorizedKey(sshPubKey)
// 	sshPubKeyStr := string(sshPubKeyBytes)
// 	return &ssh.KeyPair{PublicKey: sshPubKeyStr, PrivateKey: string(pemBytes)}, nil

// }

func TestTerraformSSH(t *testing.T) {

	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../manifest",

		VarFiles: []string{"../dev_env/dev.tfvars"},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	sshKeypair := ssh.KeyPair{
		PrivateKey: os.Getenv("BASTION_PRIVATE_KEY"),
	}

	//keys, _ := RSAKeyPairFromFile("/Downloads/bastion-key.pem")

	bastion_host := terraform.OutputList(t, terraformOptions, "bastion_instance_ip")
	//bastion_host := terraform.OutputList(t, terraformOptions, "bastion_instance_pubdns")

	maxRetries := 5
	timeBetweenRetries := 5 * time.Second

	for ip := 0; ip <= len(bastion_host); ip++ {
		description := fmt.Sprintf("SSH to public host %s", bastion_host[ip])

		retry.DoWithRetry(t, description, maxRetries, timeBetweenRetries, func() (string, error) {
			host := ssh.Host{Hostname: bastion_host[ip], SshUserName: "ec2-user", SshKeyPair: &sshKeypair}

			err := ssh.CheckSshConnectionE(t, host)

			return "", err

		})

	}

}
