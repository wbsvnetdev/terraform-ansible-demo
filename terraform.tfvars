aws_region   = "us-east-1"
project_name = "lab"
vpc_cidr     = "10.0.0.0/16"
public_cidrs = "10.0.1.0/24"
private_cidrs = "10.0.2.0/24"
accessip    = "0.0.0.0/0"

key_name = "lab_key"
public_key_path = "lab1-aws-public.ppk"
server_instance_type = "t2.micro"
instance_count = 4

