#-----networking/outputs.tf----

output "public_subnet" {
  value = "${aws_subnet.lab_public_subnet.id}"
}

output "public_cidrs" {
  value = ["${aws_subnet.lab_public_subnet.cidr_block}"]
}

output "private_subnet" {
  value = "${aws_subnet.lab_private_subnet.id}"
}

output "private_cidrs" {
  value = ["${aws_subnet.lab_private_subnet.cidr_block}"]
}

output "web_sg" {
  value = "${aws_security_group.web_sg.id}"
}


