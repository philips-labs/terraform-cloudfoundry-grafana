data "cloudfoundry_org" "org" {
  name = var.cf_org_name
}

data "cloudfoundry_service" "rds" {
  name = var.db_broker
}

data "cloudfoundry_domain" "domain" {
  name = var.cf_domain
}

data "cloudfoundry_domain" "internal" {
  name = "apps.internal"
}

data "hsdp_config" "iam" {
  service = "iam"
}

locals {
  name = var.name_postfix == "" ? "gf" : "gf-${var.name_postfix}"
}

//noinspection HILUnresolvedReference
resource "cloudfoundry_app" "grafana" {
  name         = "tf-${local.name}"
  space        = var.cf_space_id
  memory       = var.memory
  disk_quota   = var.disk
  docker_image = var.grafana_image
  environment = merge(
    var.enable_postgres ?
    {
      GF_DATABASE_HOST     = cloudfoundry_service_key.database_key[0].credentials.hostname
      GF_DATABASE_NAME     = cloudfoundry_service_key.database_key[0].credentials.db_name
      GF_DATABASE_TYPE     = "postgres"
      GF_SERVER_ROOT_URL   = "https://${cloudfoundry_route.grafana.endpoint}"
      GF_DATABASE_USER     = cloudfoundry_service_key.database_key[0].credentials.username
      GF_DATABASE_PASSWORD = cloudfoundry_service_key.database_key[0].credentials.password
      } : {
      GF_DATABASE = "disabled"
    },
    local.iam_integration ?
    {
      GF_AUTH_GENERIC_OAUTH_ALLOW_SIGN_UP            = "false"
      GF_AUTH_GENERIC_OAUTH_ALLOWED_DOMAINS          = join(",", var.email_domains)
      GF_AUTH_GENERIC_OAUTH_API_URL                  = "${data.hsdp_config.iam.url}/authorize/oauth2/userinfo?api-version=2"
      GF_AUTH_GENERIC_OAUTH_AUTH_URL                 = "${data.hsdp_config.iam.url}/authorize/oauth2/authorize?api-version=2"
      GF_AUTH_GENERIC_OAUTH_CLIENT_ID                = hsdp_iam_client.grafana[0].client_id
      GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET            = hsdp_iam_client.grafana[0].password
      GF_AUTH_GENERIC_OAUTH_EMPTY_SCOPES             = "false"
      GF_AUTH_GENERIC_OAUTH_ENABLED                  = "true"
      GF_AUTH_GENERIC_OAUTH_SCOPES                   = "openid mail email"
      GF_AUTH_GENERIC_OAUTH_TLS_SKIP_VERIFY_INSECURE = "false"
      GF_AUTH_GENERIC_OAUTH_TOKEN_URL                = "${data.hsdp_config.iam.url}/authorize/oauth2/token?api-version=2"
    } : {},
    var.environment,
    {
      GF_SECURITY_ADMIN_USER     = var.grafana_username
      GF_SECURITY_ADMIN_PASSWORD = var.grafana_password
    }
  )

  routes {
    route = cloudfoundry_route.grafana.id
  }
}

resource "cloudfoundry_service_instance" "database" {
  count        = var.enable_postgres ? 1 : 0
  name         = "tf-${local.name}-rds"
  space        = var.cf_space_id
  service_plan = data.cloudfoundry_service.rds.service_plans[var.db_plan]
  json_params  = var.db_json_params
}

resource "cloudfoundry_service_key" "database_key" {
  count            = var.enable_postgres ? 1 : 0
  name             = "key"
  service_instance = cloudfoundry_service_instance.database[count.index].id
}

resource "cloudfoundry_route" "grafana" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = var.cf_space_id
  hostname = local.name
}

resource "cloudfoundry_network_policy" "grafana" {
  count = length(var.network_policies) > 0 ? 1 : 0

  dynamic "policy" {
    for_each = [for p in var.network_policies : {
      destination_app = p.destination_app
      port            = p.port
      protocol        = p.protocol
    }]
    content {
      source_app      = cloudfoundry_app.grafana.id
      destination_app = policy.value.destination_app
      protocol        = policy.value.protocol == "" ? "tcp" : policy.value.protocol
      port            = policy.value.port
    }
  }
}
