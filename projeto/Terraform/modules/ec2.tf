# Criando EC2 para serviço web
resource "aws_instance" "srv_web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  metadata_options {
    http_tokens = "required"
  }

  iam_instance_profile = var.ssm_instance_profile_name

  # Adiciona Subnet
  subnet_id = aws_subnet.terraform-subnet.id

  # Adiciona IP publico dinâmico
  associate_public_ip_address = true

  # Adiciona SG
  vpc_security_group_ids = [aws_security_group.sg_web.id]

  # Criando nome do volume e tamanho do volume
  root_block_device {
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name        = "srv_web-${var.ambiente}"
    Plataforma  = data.aws_ami.amazon_linux.platform_details
    Environment = var.ambiente
  }

}