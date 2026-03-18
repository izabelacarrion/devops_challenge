variable "ambiente" {
  default     = "dev"
  description = "Ambiente de provisionamento da estrutura"
}

variable "bloco_ips_liberados" {
  type        = string
  description = "Define os endereços de IP liberados"
}

variable "ssm_instance_profile_name" {
  type = string
}

variable "staging_vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR da rede de desenvolvimento"
}

variable "nome_subnets" {
  type    = set(string)
  default = ["priv", "pub"]
}

variable "region" {
  type = string
}