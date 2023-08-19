resource "tls_private_key" "tw_tls_private" {
  algorithm = "RSA"
}

locals {
  private_key_filename = "${var.key_pair_prefix}-ssh-key.pem"
}

resource "local_file" "terraform-pem" {
  content  = tls_private_key.tw_tls_private.private_key_pem
  filename = "${path.module}/terraform.pem"

  depends_on = [tls_private_key.tw_tls_private]
}

resource "aws_key_pair" "tw_key_pair" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.tw_tls_private.public_key_openssh
}