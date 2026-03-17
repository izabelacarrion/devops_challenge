module "desafio_devops" {
  source                    = "./modules"
  ambiente                  = var.ambiente
  bloco_ips_liberados       = var.bloco_ips_liberados
  ssm_instance_profile_name = var.ssm_instance_profile_name
  nome_subnets              = var.nome_subnets
  cidr_bloco_da_vpc         = var.staging_vpc_cidr
  region                    = var.region
}