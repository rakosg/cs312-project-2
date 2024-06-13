#!/bin/bash
echo "bye bye minecraft! :("
terraform destroy

rm mc-proj2-key.pem
rm mc-proj2-key.pem.pem
rm mc-proj2-key.pub

rm terraform.tfstate
rm terraform.tfstate.backup

unset output
unset ip
unset dns
