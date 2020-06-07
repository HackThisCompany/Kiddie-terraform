resource "aws_vpc" "kiddie" {
  cidr_block                       = var.vpc_cidr_block
  assign_generated_ipv6_cidr_block = true

  tags = merge(
    var.tags,
    map(
      "Name", "Kiddie"
    )
  )
}

resource "aws_internet_gateway" "kiddie" {
  vpc_id = aws_vpc.kiddie.id

  tags = merge(
    var.tags,
    map(
      "Name", "Kiddie"
    )
  )
}

resource "aws_egress_only_internet_gateway" "kiddie" {
  vpc_id = aws_vpc.kiddie.id

  tags = merge(
    var.tags,
    map(
      "Name", "Kiddie"
    )
  )
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.kiddie.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "${var.region}a"

  tags = merge(
    var.tags,
    map(
      "Name", "KiddiePublic"
    )
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kiddie.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kiddie.id
  }

  tags = merge(
    var.tags,
    map(
      "Name", "KiddiePublic"
    )
  )
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.kiddie.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = "${var.region}b"

  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.kiddie.ipv6_cidr_block, 8, 0)

  tags = merge(
    var.tags,
    map(
      "Name", "KiddiePrivate"
    )
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.kiddie.id

  tags = merge(
    var.tags,
    map(
      "Name", "KiddiePrivate"
    )
  )
}

resource "aws_route" "private_eigw" {
  route_table_id              = aws_route_table.private.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.kiddie.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
