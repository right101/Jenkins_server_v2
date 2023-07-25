output "subnet_ids" {
  value = data.aws_subnets.us-east-2_default_subnets.ids
}

output "instance_public_ip" {
  value = aws_instance.myInstance.public_ip

}

output "jenkins_server" {
  value = "http://${aws_route53_record.www_jenkins.name}.${data.aws_route53_zone.my_hosted_zone.name}:8080"
}