

resource "aws_ecr_repository" "umami_ecr" {
  name                 = "umami"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  tags = {
    Name = "umami-ecr"

  }
}