#!/usr/bin/env bash

set -e
# set -x

if [ -z "${1}" ]; then
    echo "Please provide a unique identifier as a parameter, like this:"
    echo "./run_instances.sh mlucas"
    exit 1
fi

profile_name="${1}-profile"
keyname="${1}-ec2-key"
instance_name="${1}-2"

aws ec2 create-key-pair --key-name "${1}-ec2-key"
sleep 5

aws iam create-instance-profile --instance-profile-name "${profile_name}"
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
aws iam attach-role-policy \
    --role-name "${profile_name}-role" \
    --policy-arn "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
aws iam add-role-to-instance-profile \
    --instance-profile-name "${profile_name}" \
    --role-name "${profile_name}-role"


aws ec2 run-instances \
--image-id $(aws ssm get-parameters \
    --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
    --query 'Parameters[0].[Value]' --output text) \
--instance-type 't2.micro' \
--key-name "${keyname}" \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${instance_name}}]" \
--iam-instance-profile "{\"Name\": \"${profile_name}\"}"

