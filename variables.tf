# ----------------------------------------
# 1. GCP Connection Details
# ----------------------------------------
variable "project_id" {
  description = ai-project-428622
  type        = string
}

variable "region" {
  description = us-central1
  type        = string
  default     = "us-central1" # Or your preferred region
}

# ----------------------------------------
# 2. GKE Cluster Config
# ----------------------------------------
variable "cluster_name" {
  description = "llm-inference-cluster"
  type        = string
  default     = "llm-inference-cluster"
}

# ----------------------------------------
# 3. GPU Node Pool Config (Crucial for the project)
# ----------------------------------------
variable "gpu_type" {
  description = "nvidia-l4"
  type        = string
  default     = "nvidia-l4"
}

variable "gpu_count" {
  description = 1
  type        = number
  default     = 1
}
# Initial number of nodes in the GPU pool
variable "initial_node_count" {
  description = 1
  type        = number
  default     = 1
}
