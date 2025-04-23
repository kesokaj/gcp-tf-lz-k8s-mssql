module "project" {
  source = "./modules/bootstrap/1_project"
  billing_id = var.billing_id
  org_id = var.org_id
  folder_id = var.folder_id
  department = var.department
  environment = var.environment
  service_list = var.service_list
}

module "vpc" {
  depends_on = [ module.project ]  
  source = "./modules/bootstrap/2_vpc"
  alias = module.project.alias
  alias_id = module.project.alias_id
  project_id = module.project.project_id
  vpc_config = var.vpc_config
  firewall_config = var.firewall_config
  peer_allocation = var.peer_allocation
  logs_config = var.logs_config
}

module "cloudsql" {
  depends_on = [ module.vpc ]
  source = "./modules/bootstrap/3_cloudsql"
  project_id = module.project.project_id
  alias = module.project.alias
  alias_id = module.project.alias_id
  root_password = var.root_password
  region = var.region
  subnets = module.vpc.subnet_id
  network = module.vpc.vpc_id
}

module "gke" {
  depends_on = [ module.cloudsql ]
  source = "./modules/bootstrap/4_gke"
  project_id = module.project.project_id
  alias = module.project.alias
  alias_id = module.project.alias_id
  region = var.region
  subnets = module.vpc.subnet_id
  subnets_all = module.vpc.subnet_all
  network = module.vpc.vpc_id
  gke_sa = module.project.min_sa
}

module "post" {
  depends_on = [ module.gke ]
  source = "./modules/bootstrap/5_post"
  project_id = module.project.project_id
  alias = module.project.alias
  alias_id = module.project.alias_id
  region = var.region
}