#----compute/main.tf#----

data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "lab_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

data "template_file" "user-init" {

  template = "${file("${path.module}/userdata.tpl")}"
}

data "template_file" "user-init-target" {

  template = "${file("${path.module}/userdata-target.tpl")}"
}

resource "aws_instance" "ansible_master" {

  instance_type = "${var.instance_type}"
  ami           = "${lookup(var.ami,var.aws_region)}"

  tags = {
    Name = "ansible-master"
  }

  key_name               = "${aws_key_pair.lab_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${var.subnets}"
  user_data              = "${data.template_file.user-init.rendered}"

}


resource "aws_instance" "ansible_target" {

  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${lookup(var.ami,var.aws_region)}"

  tags = {
    Name = "ansible-target-0${count.index + 1}"
  }

  key_name               = "${aws_key_pair.lab_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${var.subnets}"
  user_data              = "${data.template_file.user-init-target.rendered}"

}