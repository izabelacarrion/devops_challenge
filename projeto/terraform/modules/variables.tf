variable "cidr_bloco_da_vpc" {
  description = "O bloco CIDR para a VPC"
  type        = string
}

variable "nome_subnets" {
  type        = set(string)
  description = "Lista com o nome de cada Subnet"
}

variable "ambiente" {
  type        = string
  description = "Ambiente do recurso prod ou stg"
}

variable "portas_web" {
  type    = list(number)
  default = [8080, 80]
}

variable "bloco_ips_liberados" {
  type        = string
  description = "Define os endereços de IP liberados"
}

variable "ssm_instance_profile_name" {
  type        = string
  description = "Nome do Instance Profile/Role criado no console"
}

variable "region" {
  type = string
}