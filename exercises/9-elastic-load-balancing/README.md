# Exercise #9: Elastic Load Balancing

In this exercise you will be creating an Application Load Balancer and using it to view a web page on an EC2 instance.
Do to this, take the following steps.

1. Log into AWS
1. If you did Exercise #3, then you should have an instance running Apache.  This will be the base instance that we use 
to connect to our load balancer.  If you no longer have access to that instance, you can launch Bitnami's LAMP AMI
    * https://bitnami.com/redirect/to/322295/lampstack-7.1.22-1-amidebian-x64-hvm-ebs?region=us-east-1
    * Launch the above server with default settings, but make sure that port 80 is exposed.
1. Create a security group for your load balancer.
    * In the EC2 Console, click Security Groups on the left, then click "Create Security Group".
    * Give your security group a name and a description.
    * Select the default VPC.
    * Under the "Inbound" tab, click "Add Rule"
    * Fill in the following values:
        * Type = HTTP
        * Protocol = TCP
        * Port = 80
        * Source = Anywhere
    * Click Create
* Create Your Load Balancer
    * In the EC2 Console, click on Load Balancers on the left and click "Create Load Balancer"
    * Click the "Create" button under the "Application Load Balancer"
    * Give your load balancer a name
    * Choose "Internet Facing"
    * Leave the IP address type at "ipv4"
    * Under the listeners section, it should say HTTP for the protocol and "80" for the port.
    * Under Availability Zones, select all subnets, then Click Next
    * Ignore the security warning and click next.
    * At the Security Groups screen, select the group we created earlier and click Next
    * Fill in the following information
        * Target group = "New target group"
        * Name = "<an-identifiable-name>"
        * Protocol = "HTTP"
        * Port = "80"
        * Target type = "instance"
        * Health Checks - Protocol = HTTP
        * Health Checks - Path = "/"
    * Expand Advanced health check settings and change the Healthy Threshold to 5 and the interval to 6, and the success codes to "200-301"
    * Click "Next: Register Targets"
    * Select the instance with apache, or the bitnami instance that you launched previously and click "Add to Registered"
    * Click "Next: Review"
    * Ensure your settings are correct and then click "Create"
    * Once your load balancer registers the target as healthy, you should be able to access the web page by pasting the
    dns endpoint of your new load balancer in a browser. You can find the dns endpoint of the load balancer in the 
    "Description" tab in the load balancers console when your LB is selected.
    
    
Congratulations!!! You've completed this exercise.