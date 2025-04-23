resource "google_sql_database_instance" "x" {
  name             = "${var.alias_id}-sqlserver-1"
  database_version = "SQLSERVER_2019_ENTERPRISE"
  region           = var.region
  project          = var.project_id
  root_password    = var.root_password

  settings {
    tier = "db-perf-optimized-N-2" #https://cloud.google.com/sql/docs/sqlserver/machine-series-overview#n2_machine_types
    edition = "ENTERPRISE_PLUS"
    disk_size = "500"
    disk_type = "PD_SSD"
    availability_type = "REGIONAL"

    data_cache_config {
      data_cache_enabled = true
    }

    ip_configuration {
      ipv4_enabled = true
      private_network = var.network
      psc_config {
        psc_enabled = false
      }
    }  
  }
}