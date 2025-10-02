# ----------------------------------------
# 1. GCP Connection Details
# ----------------------------------------
variable "project_id" {
  description = "Your GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the cluster"
  type        = string
  default     = "us-central1" # Or your preferred region
}

# ----------------------------------------
# 2. GKE Cluster Config
# ----------------------------------------
variable "cluster_name" {
  description = "Name for the GKE cluster"
  type        = string
  default     = "llm-inference-cluster"
}

# ----------------------------------------
# 3. GPU Node Pool Config (Crucial for the project)
# ----------------------------------------
variable "gpu_type" {
  description = "The type of NVIDIA GPU to use (e.g., L4, T4)"
  type        = string
  default     = "nvidia-l4"
}

variable "gpu_count" {
  description = "The number of GPUs per node (usually 1 for L4/T4)"
  type        = number
  default     = 1
}

variable "initial_node_count" {
  description = "The initial number of GPU nodes in the pool"
  type        = number
  default     = 1
}
