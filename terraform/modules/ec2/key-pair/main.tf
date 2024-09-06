resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key

  tags = merge({
    Name    = var.key_name
    Purpose = var.purpose
  }, var.tags)
}
