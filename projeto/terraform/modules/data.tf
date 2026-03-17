# Bloco de pesquisa da AMI
data "aws_ami" "amazon_linux" {
  most_recent = true       # Procura versao mais recente
  owners      = ["amazon"] # Qual é o dono dessa imagem, ID da Amazon


  filter {
    name   = "name" # Nome da AMI
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type" # Tipo de virtualizacao
    values = ["hvm"]
  }

}

# Busca o SNS criado na AWS 
data "aws_sns_topic" "alerta_disponivel" {
  name = "SNS01" # Nome do tópico
}