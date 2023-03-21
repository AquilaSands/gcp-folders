#!/bin/zsh

params=''
# Read the variables in local_dev.auto.tfvars and use these to build the input parameter for inspec
while IFS=$'=' read -r param value; do
  # pipe each var to tr to trim whitespace then remove double quotes
  params+="$(echo -e $param | tr -d '[:space:]' )='$(echo -e $value | tr -d '[:space:]')' "
  params=$(echo -e $params | tr -d '"')
done < '../src/terraform/local_dev.auto.tfvars'

cmd="inspec exec ./inspec -t gcp:// --input $params"
echo $cmd
eval "$cmd"
