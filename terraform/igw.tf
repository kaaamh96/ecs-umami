resource "aws_internet_gateway" "umami_igw" {

  vpc_id = aws_vpc.umami_vpc.id

  tags = {
    Name = "umami-igw"
  }
}