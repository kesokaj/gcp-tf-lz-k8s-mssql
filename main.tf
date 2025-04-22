module "project" {
  source = "./modules/bootstrap/1_project"
  billing_id = var.billing_id
  org_id = var.org_id
  org_policy_list = var.org_policy_list
  service_list = var.service_list
}

module "vpc" {
  depends_on = [ module.base ]  
  source = "./modules/bootstrap/2_vpc"
  alias = module.base.alias
  alias_id = module.base.alias_id
  project_id = module.base.project_id
  vpc_config = var.vpc_config
  firewall_config = var.firewall_config
  peer_allocation = var.peer_allocation
  logs_config = var.logs_config
}

module "cloudsql" {
  depends_on = [ module.vpc ]
  source = "./modules/bootstrap/3_cloudsql"
  project_id = module.base.project_id
  alias = module.base.alias
}

module "gke" {
  depends_on = [ module.cloudsql ]
  source = "./modules/bootstrap/4_gke"
  project_id = module.base.project_id
  alias = module.base.alias
}

module "post" {
  depends_on = [ module.gke ]
  source = "./modules/bootstrap/5_post"
  project_id = module.base.project_id
  alias = module.base.alias
}