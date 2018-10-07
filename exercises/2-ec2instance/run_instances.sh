#!/usr/bin/env bash

# Set some bashy stuff for better run
set -e
set -x

# This fun little block lets you run this script like "./run_instances.sh <your-tag-here>"
if [ -z "${1}" ]; then
    echo "Please provide a unique identifier as a parameter, like this:"
    echo "./run_instances.sh <unique-tag-for-resources> <key-name>"
    exit 1
fi

# Interpolate some variables for later use
profile_name="${1}-profile"
keyname="${2}"
instance_name="${1}-2"

# This will create the key if it doesn't exist and place it in the right directory.
create_key () {
    return_blob="$(aws ec2 create-key-pair --key-name ${1})" || return 0
    echo "${return_blob}" | \
    jq -r '.KeyMaterial' > ~/.ssh/id_rsa && \
    chmod 600 ~/.ssh/id_rsa
}

# try the create_key function
create_key "${keyname}"

sleep 5

# Create the IAM instance profile so our EC2 instance has permissions to do stuff
aws iam create-instance-profile --instance-profile-name "${profile_name}"

# Create a role to add SSM permissions to
aws iam create-role \
    --role-name "${profile_name}-role" \
    --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'

# Attach the AmazonEC2RoleforSSM so we can connect to this instance later.
aws iam attach-role-policy \
    --role-name "${profile_name}-role" \
    --policy-arn "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

# Add the role and policies we created to the instance-profile
aws iam add-role-to-instance-profile \
    --instance-profile-name "${profile_name}" \
    --role-name "${profile_name}-role"

echo "need to sleep 10 to make sure IAM has caught up"
sleep 10

# RUN OUR INSTANCE!!!
aws ec2 run-instances \
--image-id $(aws ssm get-parameters \
    --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
    --query 'Parameters[0].[Value]' --output text) \
--instance-type 't2.micro' \
--key-name "${keyname}" \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${instance_name}}]" \
--iam-instance-profile "{\"Name\": \"${profile_name}\"}"