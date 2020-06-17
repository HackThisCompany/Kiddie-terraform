resource "aws_security_group" "wintermute_straylight" {
  name        = "Wintermute Straylight SG"
  description = "Allow web and ntopng"
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

  ingress {
    description = "Allow HTTP ntopng from public"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public.cidr_block]
  }

  ingress {
    description = "Allow SMTP from public"
    from_port   = 25
    to_port     = 25
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
      "Name", "Wintermute Straylight"
    )
  )
}

#resource "aws_instance" "wintermute_straylight" {
resource "aws_spot_instance_request" "wintermute_straylight" {
  ami           = local.wintermute_straylight_ami
  spot_price    = var.wintermute_straylight_spot_price
  instance_type = var.wintermute_straylight_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.wintermute_straylight.id]
  associate_public_ip_address = false

  wait_for_fulfillment = true
  spot_type            = "one-time"

  tags = merge(
    var.tags,
    map(
      "Name", "Wintermute Straylight"
    )
  )
}
