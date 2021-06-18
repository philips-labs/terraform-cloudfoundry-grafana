output "grafana_endpoint" {
  description = "The endpoint where Grafana is reachable on"
  value       = cloudfoundry_route.grafana.endpoint
}

output "grafana_id" {
  description = "The Grafana app ID"
  value       = cloudfoundry_app.grafana.id
}

output "grafana_database_metrics_endpoint" {
  description = "The internal metrics endpoint for the Grafana database"
  value       = "http://${join("", cloudfoundry_route.pg_exporter.*.endpoint)}:9187/metrics"
}

output "grafana_database_metrics_port" {
  description = "The Grafa metrics internal port"
  value       = "9187"
}

output "grafana_database_metrics_app_id" {
  description = "The metrics app ID"
  value       = join("", cloudfoundry_app.pg_exporter.*.id)
}

