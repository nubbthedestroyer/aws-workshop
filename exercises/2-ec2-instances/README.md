# Exercise #2: Launching an EC2 Instance

In this exercise, we are going to launch two instances, connect to each, and verify that they can 
communicate with each other.  One instance will be launched in the Console and the other with the API.

## Create an EC2 Keypair

By default, Linux instances in AWS authenticate SSH using an symmetric keypair that can be generated or imported.

Lets create a keypair that we can use to connect to the instances.

```bash
keyname="<your-key-name-here>"
aws ec2 create-key-pair --key-name "${keyname}" | \
jq -r '.KeyMaterial' > ~/.ssh/id_rsa && \
chmod 600 ~/.ssh/id_rsa

```

That monster of a shell command will give you an ssh key in the right place in your IDE to connect to instances 
that are launched with that keypair.

## Launch an Instance through the console

Next, lets launch an EC2 instance through the console.

1. Click the square button in the top right of the terminal window to minimize your terminal, then click on 
"AWS Cloud9" in the top left, and then "Go to your Dashboard".  From there, you should see the services drop down
in the top left of your browser window.  
1. Click on services and find or search for "EC2" and click it to get to your EC2 Dashboard.
1. Click the blue button that says "Launch Instance"
1. The first option in the Quickstart tab of the image selector should be "Amazon Linux 2 AMI (HVM), SSD Volume Type".
Click on "Select" to the right of that.
1. Select t2.micro instance type, then click Next: Configure Instance Details.
1. Be sure that the VPC in the Network field has the (default) name.  If not, click the dropdown and select the VPC 
with the "(default)" name.  Your VPC ID will vary per each account.
1. In the Auto-Assign Public IP field, select "Enable".
1. Click "Next: Add Storage"
1. Change the "Size" value to 32.
1. Click "Next: Add Tags"
1. Click the "Add Tag" button and make the name of your new tag "Name" and the value something you'll be able to 
recognize, like "mlucas-1"
1. Click Next: Configure Security Group
1. Select "Create a new security group"
1. Give your security group a name you'll recognize, like "mlucas-sg".
1. Click "Add Rule"
1. In the "Type" dropdown, select HTTP.  Leave the other values as is.
1. Click "Review and Launch", and then Click "Launch"
1. You'll be asked to select the keypair using the name you specified earlier.

Your instance should be up and running in a few minutes.  You can watch its status by clicking on the instance ID you 
see or by visiting the AWS Console and looking at the instance list.

## Launch an EC2 instance through the CLI

EC2 instances can also be created programmatically using the AWS CLI. 

To use this method to launch your second instance, use the following command.  Be sure to edit the variables section 
at the beginning to match your requirements.  I've provided a script that you can simply edit for your convenience at 
"workshop/2-ec2instance/run_instances.sh"

#### Follow along with my super-duper script

```bash
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
```

If you were successful, you should have gotten a long JSON output with launch status that could be parsed if required.  
You should also now see your instance launching in the EC2 Dashboard, and the Instances tab on the left.