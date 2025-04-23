resource "google_container_cluster" "x" {
  provider                    = google-beta
  name                        = "${var.alias_id}-cluster-1"
  project                     = var.project_id
  location                    = var.region
  network                     = var.network
  subnetwork                  = var.subnets[0]
  networking_mode             = "VPC_NATIVE"
  datapath_provider           = "ADVANCED_DATAPATH"
  deletion_protection         = false
  enable_autopilot            = true
  disable_l4_lb_firewall_reconciliation = true

  node_config {
    logging_variant = "MAX_THROUGHPUT"

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot = true
    }

    gvnic {
      enabled = true
    }

    gcfs_config {
      enabled = true
    }
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  control_plane_endpoints_config {
    dns_endpoint_config {
      endpoint = true
      allow_external_traffic = true
    }
    ip_endpoints_config {
      enabled = false
    }
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_global_access_config {
      enabled = true
    }
  }

  security_posture_config {
    vulnerability_mode = "VULNERABILITY_BASIC"
    mode = "BASIC"
  }

  pod_autoscaling {
    hpa_profile = "PERFORMANCE"
  }

  release_channel {
    channel = "RAPID"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "pods"
    services_secondary_range_name = "services"
    
  }  

  dns_config {
    cluster_dns = "CLOUD_DNS"
    cluster_dns_scope = "CLUSTER_SCOPE"
  }

  cost_management_config {
    enabled = true
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "APISERVER",
      "CONTROLLER_MANAGER",
      "SCHEDULER",
      "WORKLOADS"
    ]
  }

  monitoring_config {
    managed_prometheus {
      enabled = true
      auto_monitoring_config {
        scope = "ALL"
      }
    }
    advanced_datapath_observability_config {
      enable_metrics = true
      enable_relay = true
    }
    enable_components = [
      "SYSTEM_COMPONENTS",
      "APISERVER",
      "SCHEDULER",
      "CONTROLLER_MANAGER",
      "STORAGE",
      "HPA",
      "POD",
      "DAEMONSET",
      "DEPLOYMENT",
      "STATEFULSET",
      "KUBELET",
      "CADVISOR",
      "JOBSET",
      "DCGM"
    ]
  }
}