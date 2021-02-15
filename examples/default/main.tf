module "grafana" {
  source = "../../"

  cf_domain    = "eu-west.philips-healthsuite.com"
  cf_org       = "abc-eu"
  cf_space     = "my-space"
  name_postfix = "default"
}
