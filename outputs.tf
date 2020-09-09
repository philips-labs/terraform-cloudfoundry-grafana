output "grafana_endpoint" {
  description = "The endpoint where Grafana is reachable on"
  value       = cloudfoundry_route.grafana.endpoint
}