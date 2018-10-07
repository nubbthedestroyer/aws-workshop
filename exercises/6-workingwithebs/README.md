# Exercise #5: Working with EBS

In this exercise, you will learn how to work with EBS.  We are going to do the following things:

* Launch an EC2 instance.
* Create an EBS volume
* Attach to the new instance.
* Connect to the instance
* Format the volume and create junk data.
* Snapshot the volume.
* Disconnect volume and destroy
* Recover volume and reconnect.

To do this, log into your supplied AWS account and follow along:

1. Launch an ec2 instance with the following characteristics
    * Amazon Linux 2
    * t2.micro
    * In the "IAM Role" dropdown, be sure to add the role you created in the previous step so we can 
    connect to the instance through SSM.  
        * If you don't see your role here, you didn't follow instructions
        or something went wrong.  Let your instructor know and he'll work it out with you.
    * Network
        * Use the default VPC (Labelled "Network"), but be sure to select the subnet from the dropdown labelled us-east-1a.
        This is important because EBS volumes are AZ specific.
    * Storage 
        * 8 GB storage default is fine.  Don't add any volumes here.
    * Tags 
        * Key = "Name"
        * Value = "ebs-exercise-<your-name>"
    * Security group = default group is fine here
    * KeyPair 
        * Select your keypair.  If it got lost somewhere along the way, thats ok since we are going to use SSM to connect.
        
1. Create an EBS volume
    * Go back to the EC2 Console.
    * Click on "Volumes" under "Elastic Block Store"
    * Click "Create Volume"
    * Fill in the form with the following information:
        * Volume Type = gp2
        * Size = 32
        * Availability Zone = < the zone you chose when you lauched the instance >
        * Tags
            Key = Name
            Value = "ebs-exercise"
        * Leave everything else at the default and hit "Create Volume"
    * Click on the instance ID in the console window to go to the volumes list and refresh the list until your volume 
    shows up and is in the "available" status.
    
1. Attach our new volume to the instance.
    * Select your volume
    * Click on the actions button above, then "Attach Volume"
    * In the dialog that appears, you can click in the "Instance" field and you should get a list of running instance instances.
    * Click the instance you created, which should be named "ebs-exercise-<your-name>"
    * Record the Device path that is populated, you will use it to find the path on your instance. 
    * Click the "Attach" button

1. Connect to your instance through SSM and format the volume.
    * Click the "Services" button above and look for "Systems Manager", click it.
    * Go to Session Manager, on the left.
    * Select your instance.
    * Update the SSM agent if prompted to do so.  If you do, wait 10 seconds and refresh the page, then select it again.
    * Click "Start Session"
    * You should be at a "sh" prompt.  
    * lets list our available EBS volumes
    
```bash
# List the devices.  xv is a special prefix to help you identify the EBS volumes
sudo ls -lah /dev/xv*
```

You should see a result like this

```
brw-rw---- 1 root disk 202,  0 Oct  7 02:22 /dev/xvda
brw-rw---- 1 root disk 202,  1 Oct  7 02:22 /dev/xvda1
brw-rw---- 1 root disk 202, 80 Oct  7 02:51 /dev/xvdf
```

Find the device that matches the final letter in the device path that you recorded later.  
This letter increments with every new volume you attach to the instance.  Now lets format and mount the volume.
NOTE: If you already know how to format linux volumes and you care about partitions way more than I do, feel 
free to heckle.
    
```bash
# replace /dev/xvdf with the path of your EBS volume.
sudo mkfs.ext4 /dev/xvdf
```

Now lets mount it somewhere.

```bash
sudo rm -rf /myebsvolume
sudo mkdir -p /myebsvolume
sudo mount -t ext4 /dev/xvdf /myebsvolume
```

As long as you didn't fat finger anything, you should be able to "cd /myebsvolume" without error.  Check that you've
mounted it right by running:

```bash
mount -l | grep myebsvolume
```

If you see your volume then congratz!  You did it!!!  Lets make some junk data and snapshot this bad boy.

```bash
sudo dd if=/dev/zero of=/myebsvolume/junk bs=1024 count=200000
```


5\. Snapshot your EBS volume.
    * Go back to the EC2 console
    * Click on "Volumes" under the "Elastic Block Store" section on the left.
    * Find your volume and select it, then click "Actions" button above and click "Create Snapshot"
    * Optionally add a description and tags.
    * Click "Create Snapshot"
    

Congratulations!  You've completed this exercise!