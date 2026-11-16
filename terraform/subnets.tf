


#public subnets

resource "aws_subnet" "umami_public_1a" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "umami-public-1a"
  }
}


resource "aws_subnet" "umami_public_1b" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true
  tags = {

    Name = "umami-public-1b"
  }



}


#private subnets


resource "aws_subnet" "umami_private_1a" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "umami-private-1a"
  }

}


resource "aws_subnet" "umami_private_1b" {
  vpc_id                  = aws_vpc.umami_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "umami-private-1b"
  }
}