output "grafana_endpoint" {
  description = "The endpoint where Grafana is reachable on"
  value       = cloudfoundry_route.grafana.endpoint
}

output "grafana_id" {
  description = "The Grafana's id"
  value       = cloudfoundry_app.grafana.id
}