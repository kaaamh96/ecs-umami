terraform {
  backend "s3" {
    bucket       = "umamistate-kam"
    key          = "umami/terraform.tfstate"
    region       = "eu-west-1"
    profile      = "kamumami"
    encrypt      = true
    use_lockfile = true
  }
}
