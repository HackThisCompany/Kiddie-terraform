resource "aws_security_group" "dc9" {
  name        = "DC-9 SG"
  description = "Allow web"
  vpc_id      = aws_vpc.kiddie.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic from private subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.private.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    map(
      "Name", "DC-9"
    )
  )
}

#resource "aws_instance" "dc9" {
resource "aws_spot_instance_request" "dc9" {
  ami           = local.dc9_ami
  spot_price    = var.dc9_spot_price
  instance_type = var.dc9_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.dc9.id]
  associate_public_ip_address = true

  wait_for_fulfillment = true
  #spot_type            = "one-time"

  tags = merge(
    var.tags,
    map(
      "Name", "DC-9"
    )
  )
}
