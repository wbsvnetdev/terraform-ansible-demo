#----root/outputs.tf-----

#---Networking Outputs -----

output "public_subnets" {
  value = "${module.networking.public_subnet}"
}

output "subnet_ips" {
  value = "${module.networking.public_cidrs}"
}

output "web_sg" {
  value = "${module.networking.web_sg}"
}


