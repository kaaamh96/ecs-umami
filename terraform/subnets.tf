


#public subnets

resource "aws_subnet" "umami_public_1a" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = var.public_subnet_1a_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = true
  tags = {
    Name = "umami-public-1a"
  }
}


resource "aws_subnet" "umami_public_1b" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = var.public_subnet_1b_cidr
  availability_zone       = var.availability_zone_1b
  map_public_ip_on_launch = true
  tags = {

    Name = "umami-public-1b"
  }



}


#private subnets


resource "aws_subnet" "umami_private_1a" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = var.private_subnet_1a_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = false
  tags = {
    Name = "umami-private-1a"
  }

}


resource "aws_subnet" "umami_private_1b" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = var.private_subnet_1b_cidr
  availability_zone       = var.availability_zone_1b
  map_public_ip_on_launch = false
  tags = {
    Name = "umami-private-1b"
  }
}