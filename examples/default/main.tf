module "grafana" {
  source = "../../"

  cf_domain        = "eu-west.philips-healthsuite.com"
  cf_org_name      = "abc-eu"
  cf_space_id      = "my-space-id"
  name_postfix     = "default"
  grafana_username = "admin"
  grafana_password = "password"
}
