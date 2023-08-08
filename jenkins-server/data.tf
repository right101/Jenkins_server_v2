data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "owner-id"
    values = ["099720109477"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"]
  }
}

data "aws_vpc" "default_vpc" {
  default = true
}



data "aws_subnets" "us-east-2_default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}


data "template_file" "user_data" {
  template = file("scripts/user_data.sh")
}

data "aws_route53_zone" "my_hosted_zone" {
  name = "creativeunicorn.net"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


data "aws_iam_policy_document" "ec2_full_access_policy" {
  statement {
    actions   = ["ec2:*"]
    resources = ["*"]
    effect    = "Allow"
  }
}
