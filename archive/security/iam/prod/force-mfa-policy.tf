# Force MFA
data "aws_iam_policy_document" "force_mfa_doc" {
  statement {
    sid = "AllowAllUsersToListAccounts"
    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
  statement {
    sid = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]
    effect = "Allow"
  }
  statement {
    sid = "AllowIndividualUserToManageTheirOwnMFA"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
    effect = "Allow"
  }
  statement {
    sid = "AllowIndividualUserToListOnlyTheirOwnMFA"
    actions = [
      "iam:ListMFADevices"
    ]
    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
    effect = "Allow"
  }
  statement {
    sid = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    actions = [
      "iam:DeactivateMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "force_mfa_policy" {
  name        = "force-mfa-policy"
  description = "Force MFA for IAM users"
  policy      = data.aws_iam_policy_document.force_mfa_doc

  tags = {
    Name       = "force-mfa-policy"
    Purpose    = "Force MFA for users to self-manage IAM credentials"
    Managed_By = "Terraform"
  }
}
