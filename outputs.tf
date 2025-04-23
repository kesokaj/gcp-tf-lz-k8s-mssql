output "project_id" {
  value = module.project.project_id
}

output "project_number" {
  value = module.project.project_number
}

output "alias" {
  value = module.project.alias
}

output "alias_id" {
  value = module.project.alias_id
}

output "gke_cluster" {
  value = module.gke.gke_cluster
}

output "cloudsql" {
  value = module.cloudsql.sql_instance
}

output "bucket" {
  value = module.post.bucket
}