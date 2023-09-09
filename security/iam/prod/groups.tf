# Developer Group
resource "aws_iam_group" "developers" {
  name = "thatsnotamuffin-developers"
}

resource "aws_iam_group_policy_attachment" "ecr_read_dev" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  depends_on = [
    aws_iam_group.developers
  ]
}

resource "aws_iam_group_policy_attachment" "force_mfa_developers" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.force_mfa_policy.arn

  depends_on = [
    aws_iam_group.developers
  ]
}

resource "aws_iam_user_group_membership" "user_1_membership" {
  user = aws_iam_user.user_1.name

  groups = [
    aws_iam_group.developers
  ]

  depends_on = [ 
    aws_iam_user.user_1,
    aws_iam_group.developers
   ]
}

resource "aws_iam_user_group_membership" "user_2_membership" {
  user = aws_iam_user.user_2.name

  groups = [
    aws_iam_group.developers
  ]

  depends_on = [ 
    aws_iam_user.user_2,
    aws_iam_group.developers
   ]
}

resource "aws_iam_user_group_membership" "user_3_membership" {
  user = aws_iam_user.user_3.name

  groups = [
    aws_iam_group.developers
  ]

  depends_on = [ 
    aws_iam_user.user_3,
    aws_iam_group.developers
   ]
}

# Infrastructure Engineers
resource "aws_iam_group" "infrastructure_engineers" {
  name = "thatsnotamuffin-infra-engineers"
}

resource "aws_iam_group_policy_attachment" "ecr_read_infra" {
  group      = aws_iam_group.infrastructure_engineers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  depends_on = [
    aws_iam_group.infrastructure_engineers
  ]
}

resource "aws_iam_group_policy_attachment" "force_mfa_infra" {
  group      = aws_iam_group.infrastructure_engineers.name
  policy_arn = aws_iam_policy.force_mfa_policy.arn

  depends_on = [
    aws_iam_group.infrastructure_engineers
  ]
}

resource "aws_iam_user_group_membership" "user_4_membership" {
  user = aws_iam_user.user_4.name

  groups = [
    aws_iam_group.developers
  ]

  depends_on = [ 
    aws_iam_user.user_4,
    aws_iam_group.developers
   ]
}

resource "aws_iam_user_group_membership" "user_5_membership" {
  user = aws_iam_user.user_5.name

  groups = [
    aws_iam_group.developers
  ]

  depends_on = [ 
    aws_iam_user.user_5,
    aws_iam_group.developers
   ]
}

resource "aws_iam_user_group_membership" "user_6_membership" {
  user = aws_iam_user.user_6.name

  groups = [
    aws_iam_group.developers
  ]

  depends_on = [ 
    aws_iam_user.user_6,
    aws_iam_group.developers
   ]
}
