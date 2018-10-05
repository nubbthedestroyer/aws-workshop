# Exercise #3: Connecting to your EC2 Instance

In this exercise, you are going to connect to the instances that you launched in exercise #2.  If you didn't do #2,
go back and do it you slacker.  :-)

## Connect to instance through Cloud9 IDE

In a previous exercise, you created a key pair, which you then added to your EC2 instance.  We are going to use this 
keypair now to connect to the first instance you launched.  We need the IP address of the instance first, however. 
The easiest way to get this is: 
1. Go into the EC2 Dashboard
1. Click on the instances tab
1. Find the instance you would like to connect to and select it.
1. In the details panel below, you should see "Private IPs" (should only be one).  Record this IP address.
1. In your Cloud9 IDE use the following command to connect to your instance.

```bash
ssh ec2-user@<ip-address-of-your-instance>
```

You may get a warning about host authenticity.  This is showing because you've not connected to this instance in the past.
You can safely ignore by typing "yes" and hitting enter.  You should now be connected to your instance via SSH.  You know
you are successful if you see a banner motd that says Amazon Linux 2 AMI.

Lets go ahead and update this machine to correct any security flaws due to old package versions.

```bash
sudo yum -y update
```

This will take a few minutes.  After it completes, we are just going to install a simple web server on this EC2 Instance.

```bash
sudo yum -y install httpd
sudo service httpd start

```

Now lets use the EC2 meta-data API to get the public IP address of the instance.  This can also be found in the 
EC2 Dashboard in the same way that we got the private IP address earlier.  

```bash
curl http://169.254.169.254/latest/meta-data/public-ipv4
```

After running that command, you should get an IP address.  You can click the IP address or copy it to a new browser 
tab to check to see if the web server is working.  If everything went right then you should now see an Apache page.

## Connect to instance through AWS Systems Manager

There is a super cool and very new feature called Sessions in AWS Systems Manager that allows for zero config access to
EC2 instances running in AWS.  It allows for granular permissions to be set such that an administrator can control who
can connect to which instances, and also allows for detailed logging to s3 for accountability.

To try this out:

1. Go back to AWS and click the "Services" dropdown, and click on or Search for "Systems Manager".  
1. Click on Session Manager on the left
1. Click "Start Session"
1. Locate the instance you launched via command line, select it and click "Start Session"

You will be presented with a black screen and a "sh" terminal.  The more familiar "bash" can be executed by entering
"bash" at the terminal window and hitting enter.

Congratulations!  You connected to some instances like a boss!