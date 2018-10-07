# Exercise #4: Baking an Image

Amazon Web Service's Elastic Compute Cloud uses what they call "Amazon Machine Images", or AMIs, as the fundamental 
storage-level building block for instances.  All instances are based on an AMI and most AMIs are based on a core AMI, 
like Amazon Linux or Ubuntu.

The AMI includes the operating system, packages, configuration, and data, but does not include the configuration for 
launching an instance like instance type.  This is a great way to prepare a base image that software can be deployed 
onto and distributed.

In this exercise, we are going to take an AMI of one of the servers that we launched in the previous exercise.

## How to take an AMI

1. Open the AWS Console, expand the services menu and click on EC2.
1. Click on the "Instances" tab on the left and find the instance you would like to image and select it.
1. Click "Actions" above the instance list in the EC2 dashboard, then "Image", then "Create Image"
1. Give the image a name and a description.
    1. You have an opportunity here to change the size of any EBS volumes attached to the running instance, and you 
will have another chance when you launch a new image from the AMI.
1. VERY IMPORTANT!!! - Check No Reboot!!!
    1. When creating an AMI, you have the option to shut down the instance before you take the snapshot, which can 
    help ensure data integrity, but should be planned in a maintenance window. 
1. Click create image.
1. There is a link to view the pending image, click that and you will be directed to the AMI panel with a search 
for your pending ami id.

The AMI can take several minutes to complete, but once this is done you could launch another instance 