locals {
  dc9_ami                   = data.aws_ami.amazon_linux_2.id
  wintermute_straylight_ami = data.aws_ami.amazon_linux_2.id
}

# AMI Amazon Linux 2
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*"]
  }
}
