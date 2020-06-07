resource "aws_security_group" "back" {
  name        = "Back SG"
  description = "Allow web"
  vpc_id      = aws_vpc.kiddie.id

  ingress {
    description = "Allow SSH from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public.cidr_block]
  }

  ingress {
    description = "Allow HTTP from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tags,
    map(
      "Name", "Back"
    )
  )
}

#resource "aws_spot_instance_request" "dc9" {
resource "aws_instance" "back" {
  ami = local.dc9_ami
  #spot_price    = var.dc9_spot_price
  instance_type = local.dc9_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.back.id]
  associate_public_ip_address = false

  tags = merge(
    var.tags,
    map(
      "Name", "Back"
    )
  )
}
