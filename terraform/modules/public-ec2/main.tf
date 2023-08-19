data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "tw_instance" {
  count                       = 2
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.pubic_ec2_instance_type
  key_name                    = var.aws_key_name
  associate_public_ip_address = true
  subnet_id                   = var.aws_subnet_ids[count.index]
  vpc_security_group_ids      = [var.aws_sg_id]
  iam_instance_profile        = var.aws_ec2_codedeploy_instance_profile_name

  tags = {
    Name = var.public_ec2_name
  }
}

resource "aws_eip" "tw_eip" {
  count    = length(aws_instance.tw_instance[*].id)
  instance = aws_instance.tw_instance[count.index].id
  domain   = "vpc"
}

resource "aws_eip_association" "tw_eip_association" {
  count         = length(aws_instance.tw_instance[*].id)
  instance_id   = aws_instance.tw_instance[count.index].id
  allocation_id = aws_eip.tw_eip[count.index].id
}

resource "null_resource" "configure-cat-app" {
  depends_on = [aws_eip_association.tw_eip_association]
  count      = length(aws_eip.tw_eip[*].public_ip)

  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "sudo apt -y update",
      "sleep 20",
      "sudo apt -y install openjdk-17-jdk",
      "sleep 20",
      #codedeploy 설치
      "sudo apt -y install ruby-full",
      "sleep 20",
      "sudo apt -y install wget",
      "wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install",
      "chmod +x ./install",
      "sudo ./install auto",

      "sudo apt -y install cowsay",
      "sleep 20",
      "cowsay Mooooooooooo!",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.aws_private_pem
      host        = aws_eip.tw_eip[count.index].public_ip
    }
  }
}