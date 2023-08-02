resource "aws_iam_role" "jenkins_iam_role" {
  name               = "jenkins-server-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = {
    Name = "Jenkins-server-Admin-Role"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.jenkins_iam_role.name
}


resource "aws_iam_policy" "ec2_full_acces_policy" {
  name        = "EC2FullAccessPolicy"
  description = "Provides admin access to EC2 Instance"
  policy      = data.aws_iam_policy_document.ec2_full_access_policy.json

}

resource "aws_iam_policy_attachment" "attach_iam_policy_to_role" {
  name       = "AttachAdminAccessForEC2Role"
  roles      = [aws_iam_role.jenkins_iam_role.name]
  policy_arn = aws_iam_policy.ec2_full_acces_policy.arn
}