# Criando a VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = var.cidr_bloco_da_vpc

  tags = {
    Name = "VPC-${var.ambiente}"
  }
}

# Criando a subnet
resource "aws_subnet" "terraform-subnet" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = join("", cidrsubnets(aws_vpc.terraform-vpc.cidr_block, 8))
  map_public_ip_on_launch = true

  tags = {
    Name = "SUB-${var.ambiente}"
  }
}

#Cria tabela de roteamento e adiciona rota para gw padrao
resource "aws_route_table" "rt-terraform" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-gw.id
  }

  tags = {
    Name = "RT-${var.ambiente}"
  }
}



# Cria internet gateway
resource "aws_internet_gateway" "terraform-gw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "IGW-${var.ambiente}"
  }
}

# Associa tabela de roteamento criada 
resource "aws_route_table_association" "rta-terraform" {
  subnet_id      = aws_subnet.terraform-subnet.id
  route_table_id = aws_route_table.rt-terraform.id
}