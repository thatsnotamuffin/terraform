# Developers
resource "aws_iam_user" "user_1" {
  name          = "thatsnotamuffin-user-1"
  force_destroy = false

  tags = {
    Name       = "thatsnotamuffin-user-1"
    Email      = "user-1@myurl.com"
    Supervisor = "My Supervisor"
    Team       = "R&D"
    Managed_By = "Terraform"
  }
}

resource "aws_iam_user" "user_2" {
  name          = "thatsnotamuffin-user-2"
  force_destroy = false

  tags = {
    Name       = "thatsnotamuffin-user-2"
    Email      = "user-2@myurl.com"
    Supervisor = "My Supervisor"
    Team       = "R&D"
    Managed_By = "Terraform"
  }
}

resource "aws_iam_user" "user_3" {
  name          = "thatsnotamuffin-user-3"
  force_destroy = false

  tags = {
    Name       = "thatsnotamuffin-user-3"
    Email      = "user-3@myurl.com"
    Supervisor = "My Supervisor"
    Team       = "R&D"
    Managed_By = "Terraform"
  }
}

# Infrastructure Engineers
resource "aws_iam_user" "user_4" {
  name          = "thatsnotamuffin-user-4"
  force_destroy = false

  tags = {
    Name       = "thatsnotamuffin-user-4"
    Email      = "user-4@myurl.com"
    Supervisor = "My Supervisor"
    Team       = "Infrastructure"
    Managed_By = "Terraform"
  }
}

resource "aws_iam_user" "user_5" {
  name          = "thatsnotamuffin-user-5"
  force_destroy = false

  tags = {
    Name       = "thatsnotamuffin-user-5"
    Email      = "user-5@myurl.com"
    Supervisor = "My Supervisor"
    Team       = "Infrastructure"
    Managed_By = "Terraform"
  }
}

resource "aws_iam_user" "user_6" {
  name          = "thatsnotamuffin-user-6"
  force_destroy = false

  tags = {
    Name       = "thatsnotamuffin-user-6"
    Email      = "user-6@myurl.com"
    Supervisor = "My Supervisor"
    Team       = "Infrastructure"
    Managed_By = "Terraform"
  }
}
