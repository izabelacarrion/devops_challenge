#Cria um SG para a VPC que não é a padrão
resource "aws_security_group" "sg_terraform" {
  name        = "sg_${var.ambiente}"
  description = "SG do ambiente ${var.ambiente}"
  vpc_id      = aws_vpc.terraform-vpc.id

  egress { # Regra de saída
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg_${var.ambiente}"
    Environment = var.ambiente
  }
}

#Cria um SG para o recurso que é a EC2
resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "SG SRV Web"
  vpc_id      = aws_vpc.terraform-vpc.id

  dynamic "ingress" {
    for_each = var.portas_web
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress { # Regra de saída
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg_web"
    Environment = var.ambiente
  }
}

# Cria uma regra de entrada liberando SSH para um bloco de endereços especificos
resource "aws_vpc_security_group_ingress_rule" "lib_meu_ssh" {
  for_each = toset(compact([for ip in split("\n", var.bloco_ips_liberados) : trimspace(ip)]))

  security_group_id = aws_security_group.sg_web.id
  cidr_ipv4         = each.value
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "SSH"
}