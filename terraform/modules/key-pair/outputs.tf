output "output_key_name" {
  description = "ec2 key_name입니다."
  value       = aws_key_pair.tw_key_pair.key_name
}

output "output_private_pem" {
  description = "ec2 접근을 위한 ssh용도 private pem입니다."
  value       = tls_private_key.tw_tls_private.private_key_pem
}