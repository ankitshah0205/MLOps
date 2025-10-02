# Configure the Google Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Create the GKE Cluster Control Plane
resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.region
  initial_node_count       = 1 # Start with 1 CPU node for the control plane
  remove_default_node_pool = true # We will define our own node pool
  
  # Enable necessary features
  networking_mode = "VPC_NATIVE"
  
  # Auto-repair and auto-upgrade are production best practices
  node_auto_repair  = true
  node_auto_upgrade = true
}

# 2. Create the GPU Node Pool (The Accelerator)
resource "google_container_node_pool" "gpu_node_pool" {
  name       = "gpu-pool-${var.gpu_type}"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.initial_node_count

  # Spot VMs for cost savings (Highly recommended for development projects)
  # Set this to true for huge cost reduction on the GPU portion
  node_config {
    machine_type = "g2-standard-4" # Recommended machine type for L4
    disk_size_gb = 100
    
    # --- CRITICAL: GPU CONFIGURATION ---
    guest_accelerator {
      type  = var.gpu_type
      count = var.gpu_count
    }
    
    # --- CRITICAL: Auto-installed NVIDIA drivers and device plugin ---
    metadata = {
      # This metadata instructs GKE to automatically install the necessary NVIDIA software.
      "gke-accelerator-type" = var.gpu_type 
    }

    # Ensure high-availability resources (Taints prevent non-GPU workloads)
    taint {
      key    = "nvidia.com/gpu"
      value  = "present"
      effect = "NO_SCHEDULE"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  # Enable cluster autoscaling for production readiness
  autoscaling {
    max_node_count = 3 
    min_node_count = 0 # Scale down to zero when not in use to save cost!
  }
}
