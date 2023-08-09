resource "aws_instance" "myInstance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.us-east-2_default_subnets.ids[1]
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  #   user_data              = file("${path.module}/scripts/configure_jenkins.yml")
  user_data = data.template_file.user_data.rendered
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }
  tags = merge({
    Name = "my-${var.instance_name}" },
    local.common_tags

  )
}



resource "aws_security_group" "jenkins_sg" {
  name        = "allow_web"
  description = "allow ports 22,80"
  vpc_id      = data.aws_vpc.default_vpc.id
  tags = {
    Name = "jenkins-sg"
  }
}


resource "aws_security_group_rule" "ingress22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.network
  security_group_id = aws_security_group.jenkins_sg.id
}


resource "aws_security_group_rule" "ingress80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "ingressHTTPS" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.https_cidr
  security_group_id = aws_security_group.jenkins_sg.id
}


resource "aws_security_group_rule" "engress443" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "engress80" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "engress22" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.my_hosted_zone.id
  name    = "www.jenkins.creativeunicorn.net"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.myInstance.public_ip]
}

resource "aws_route53_record" "www_jenkins" {
  zone_id = data.aws_route53_zone.my_hosted_zone.id
  name    = "jenkins.creativeunicorn.net"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.myInstance.public_ip]
}


