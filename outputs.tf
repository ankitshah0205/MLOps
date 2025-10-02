output "cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster."
}

output "kubeconfig_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region ${var.region} --project ${var.project_id}"
  description = "Run this command to configure kubectl to connect to your new cluster."
}
