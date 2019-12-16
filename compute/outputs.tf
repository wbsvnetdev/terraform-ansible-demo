#-----compute/outputs.tf-----

output "server_id" {
  value = "${aws_instance.ansible_master.id}"
}

output "server_ip" {
  value = "${aws_instance.ansible_master.public_ip}"
}
