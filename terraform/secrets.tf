resource "aws_secretsmanager_secret" "umami_app_secret" {
  name        = "umami/app-secret"
  description = "application secret for umami"
  tags = {
    Name = "umami-app-secret"
  }
}

# will put actual value on secrets manager after deployment
