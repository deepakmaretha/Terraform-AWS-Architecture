# Terraform-AWS-Architecture
Creates AWS Architecture and deploys a test static application through IaC (HCL Terraform).

Create environment tfvars file before running this terraform script

Example: 

access_key = "YOUR_ACCESS_KEY"

secret_key = "YOUR_SECRET_KEY"

region = "REGION"

userdata = "userdata.sh"

userdata2 = "userdata2.sh"

ami = "Enter AMI ID"

instance_type = "instance-type" # You can use Free Tiar to run this test project.


Architecture Diagram

![aws architacture](https://github.com/deepakmaretha/Terraform-AWS-Architecture/assets/140425938/a6ea3412-971a-40cb-93f4-fd740177f9f0)

The server can be accessible through Application Load Balancer's DNS. 

You can get the DNS in Output of the Terraform apply command.
