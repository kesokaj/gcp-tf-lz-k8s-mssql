resource "null_resource" "set_project" {
  triggers = {
    always_run = "${timestamp()}"
  }  
  provisioner "local-exec" {
    command = "gcloud config set project ${var.project_id}"
  }
}

resource "google_storage_bucket" "x" {
  name          = "${var.alias_id}-bucket-1"
  location      = var.region
  project       = var.project_id
  force_destroy = true

  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
}