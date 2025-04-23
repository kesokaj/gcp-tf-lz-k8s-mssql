variable "billing_id" {
  type = string
}

variable "org_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "region" {
  type = string
  default = "europe-north1"
}

variable "root_password" {
  type = string
  default = "Passw0rd123!"
}

variable "department" {
  type = string
  default = "billiant"
}

variable "environment" {
  type = string
  default = "development"
  
}

variable "firewall_config" {
  type = map(any)
  description = "Firewall rules in VPC"
  default = {
    "allow-rdp-tcp": {
      "protocol" : "tcp",
      "ports" : ["3389"],
      "tags": ["rdp"],
      "source" : ["0.0.0.0/0"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "100"
    },
    "allow-ssh-tcp": {
      "protocol" : "tcp",
      "ports" : ["22"],
      "tags": ["ssh"],
      "source" : ["0.0.0.0/0"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "100"
    },
    "allow-healthcheck-tcp": {
      "protocol" : "tcp",
      "ports": ["0-65535"],
      "tags": [],
      "source" : ["130.211.0.0/22","35.191.0.0/16","209.85.152.0/22","209.85.204.0/22"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "30000"
    },
    "allow-healthcheck-udp": {
      "protocol" : "udp",
      "ports": ["0-65535"],
      "tags": [],
      "source" : ["130.211.0.0/22","35.191.0.0/16","209.85.152.0/22","209.85.204.0/22"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "30000"
    },    
    "allow-iap-tcp": {
      "protocol" : "tcp",
      "tags": [],      
      "ports": ["0-65535"],
      "source" : ["35.235.240.0/20"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "30000"
    },
    "allow-iap-udp": {
      "protocol" : "udp",
      "tags": [],      
      "ports": ["0-65535"],
      "source" : ["35.235.240.0/20"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "30000"
    },    
    "allow-icmp": {
      "protocol" : "icmp",
      "ports": [],
      "tags": [],      
      "source" : ["0.0.0.0/0"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "65534"
    },
    "allow-internal-tcp": {
      "protocol" : "tcp",
      "ports": ["0-65535"],
      "tags": [],      
      "source" : ["10.0.0.0/8"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "65534"
    },
    "allow-internal-udp": {
      "protocol" : "udp",
      "ports": ["0-65535"],
      "tags": [],      
      "source" : ["10.0.0.0/8"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "65534"
    },    
    "allow-http": {
      "protocol" : "tcp",
      "ports": ["80"],
      "tags": ["http"],
      "source" : ["0.0.0.0/0"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "100"
    },
    "allow-https": {
      "protocol" : "tcp",
      "ports": ["443"],
      "tags": ["https"],
      "source" : ["0.0.0.0/0"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "100"
    },
    "allow-custom": {
      "protocol" : "tcp",
      "ports": ["8080","3000","2222","8443"],
      "tags": ["custom"],
      "source" : ["0.0.0.0/0"],
      "logs" : "INCLUDE_ALL_METADATA",
      "priority" : "100"
    },       
  }
}

variable "vpc_config" {
  type        = map(any)
  description = "Regions for VPC Subnets to be created"
  default = {
    "europe-north1" : {
      "vpc_subnet_cidr" : "10.1.0.0/22"
      "secondary_ranges" :{
        "psc" : "10.1.4.0/26",        
        "glproxy" : "10.1.5.0/25",
        "rmproxy" : "10.1.5.128/25",
        "pnat" : "10.1.6.0/24",       
        "services" : "10.1.16.0/20",
        "pods" : "10.1.128.0/17",              
      }
    }
  }
}

variable "logs_config" {
  type = map(any)
  description = "Logging from subnets (flowlogs)"
  default = {
    "subnet" : {
      "interval" : "INTERVAL_15_MIN",
      "samples" : "0.25",
      "metadata" : "INCLUDE_ALL_METADATA"
    },
    "router" : {
      "enable" : "true",
      "filter" : "ALL" #ERRORS
    }
  }
}

variable "peer_allocation" {
  type = string
  description = "Peering network for different services a /20 will be used"
  default = "10.100.0.0"
}

variable "service_list" {
  type = list(any)
  default = [
    "orgpolicy.googleapis.com",  # Organization Policy Service - For managing organization-wide policies and constraints
    "dns.googleapis.com",        # Cloud DNS - For managing DNS records and zones
    "compute.googleapis.com",     # Compute Engine - For creating and managing virtual machines
    "networkmanagement.googleapis.com",  # Network Management - For network monitoring, troubleshooting, and optimization
    "servicenetworking.googleapis.com",  # Service Networking - For connecting, securing, and observing services
    "servicedirectory.googleapis.com",  # Service Directory - For service discovery and management
    "networkconnectivity.googleapis.com",  # Network Connectivity - For managing network connections across your infrastructure
    "cloudaicompanion.googleapis.com",  # Cloud AI Companion - (Commented out) For AI-powered assistance and automation
    "cloudquotas.googleapis.com", # Enable quota metrics in the console - For viewing and managing resource quotas
    "logging.googleapis.com",    # Cloud Logging - For collecting, storing, and analyzing log data
    "monitoring.googleapis.com",  # Cloud Monitoring - For monitoring the performance and availability of your applications and infrastructure
    "clouderrorreporting.googleapis.com",  # Cloud Error Reporting - For tracking and managing application errors
    "cloudtrace.googleapis.com",  # Cloud Trace - For distributed tracing and debugging of applications
    "opsconfigmonitoring.googleapis.com",  # Ops Config Monitoring - For monitoring the configuration of your systems
    "servicehealth.googleapis.com",  # Service Health - For getting information about Google Cloud service health
    "cloudlatencytest.googleapis.com",  # Cloud Latency Test - For measuring network latency to Google Cloud regions
    "timeseriesinsights.googleapis.com",  # Time Series Insights - For storing, analyzing, and querying time series data
    "checks.googleapis.com",      # Cloud Monitoring Checks - For creating and managing uptime checks
    "cloudidentity.googleapis.com",  # Cloud Identity - For managing user identities and access control
    "containersecurity.googleapis.com",  # Container Security - For securing your containerized applications
    "certificatemanager.googleapis.com",  # Certificate Manager - For provisioning and managing SSL/TLS certificates
    "artifactregistry.googleapis.com",  # Artifact Registry - For storing and managing build artifacts and dependencies
    "cloudbuild.googleapis.com",   # Cloud Build - For building and deploying applications
    "containerregistry.googleapis.com",  # Container Registry - For storing and managing Docker images
    "osconfig.googleapis.com",     # OS Config - For managing and configuring operating systems
    "bigqueryconnection.googleapis.com",  # BigQuery Connection - For connecting to BigQuery from external applications
    "biglake.googleapis.com",     # BigLake - For managing and querying data lakes
    "networkservices.googleapis.com",  # Network Services - For managing network services like load balancing and traffic management
    "edgenetwork.googleapis.com",  # Edge Network - For deploying and managing applications at the edge of the network
    "networktopology.googleapis.com",  # Network Topology - For visualizing and understanding your network topology
    "vpcaccess.googleapis.com",    # VPC Access - For connecting to your VPC network from on-premises or other cloud environments
    "tagmanager.googleapis.com",   # Tag Manager - For managing tags and resources
    "pubsub.googleapis.com",      # Cloud Pub/Sub - For asynchronous messaging and data ingestion
    "pubsublite.googleapis.com",  # Cloud Pub/Sub Lite - For cost-effective, high-throughput messaging
    "cloudresourcemanager.googleapis.com",  # Cloud Resource Manager - For managing your cloud resources, including projects, folders, and organizations
    "firewallinsights.googleapis.com",  # Firewall Insights - For analyzing firewall logs and traffic
    "datastudio.googleapis.com",  # Data Studio - For creating interactive dashboards and reports
    "cloud.googleapis.com",       # Google Cloud APIs -  A general API for accessing various Google Cloud services
    "storage-component.googleapis.com",  # This likely refers to a lower-level API that handles specific components within Cloud Storage. It might be used for things like managing buckets, objects, and access control lists, but it's generally not used directly by end-users.
    "storage.googleapis.com",      # *This is the main API for interacting with Google Cloud Storage. It provides a high-level interface for storing and retrieving data in buckets.
    "storageinsights.googleapis.com",   # This API is used for monitoring and analyzing your Cloud Storage usage. It can provide insights into things like storage costs, data growth, and access patterns.
    "networksecurity.googleapis.com",
    "recommender.googleapis.com",
    "cloudasset.googleapis.com",
    "maintenance.googleapis.com",
    "serviceusage.googleapis.com",
    "container.googleapis.com"
  ]
}

