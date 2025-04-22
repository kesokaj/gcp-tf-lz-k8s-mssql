resource "google_sql_database_instance" "x" {
  name             = "${var.alias}-instance1"
  database_version = "SQLSERVER_2019_ENTERPRISE"
  region           = "europe-west1"
  project          = var.project_id
  root_password    = "Passw0rd123!" 

  settings {
    tier = "db-perf-optimized-N-2" #https://cloud.google.com/sql/docs/sqlserver/machine-series-overview#n2_machine_types
    edition = "ENTERPRISE_PLUS"
    disk_size = "500"
    availability_type = "REGIONAL"

    data_cache_config {
      data_cache_enabled = true
    }
    ip_configuration {
      ipv4_enabled = true
      private_network = var.network
      psc_config {
        psc_enabled = true
      }
    }
  }
}