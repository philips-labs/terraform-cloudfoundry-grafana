locals {
  iam_integration = var.iam_application_id != ""
}

resource "random_password" "client_password" {
  count            = local.iam_integration ? 1 : 0
  length           = 16
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "-!@#.:_?{$}"
}

resource "random_uuid" "client_uuid" {
}

resource "hsdp_iam_client" "grafana" {
  count               = local.iam_integration ? 1 : 0
  type                = "Confidential"
  name                = "TF_GRAFANA_${local.name}"
  description         = "Grafana OAuth2 Client"
  client_id           = "tf_grafana_${local.name}"
  global_reference_id = random_uuid.client_uuid.result
  application_id      = var.iam_application_id
  password            = random_password.client_password[count.index].result
  scopes              = ["openid", "mail", "email", "profile"]
  default_scopes      = ["openid", "mail", "email", "profile"]
  response_types      = ["code"]
  //noinspection HILUnresolvedReference
  redirection_uris = [
    "https://${cloudfoundry_route.grafana.endpoint}/grafana/login/generic_oauth"
  ]
}
