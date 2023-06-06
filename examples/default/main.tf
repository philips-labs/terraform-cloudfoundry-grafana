module "grafana" {
  source = "../../"

  cf_space_id      = "my-space-id"
  name_postfix     = "default"
  grafana_username = "admin"
  grafana_password = "password"
}
