resource "cloudfoundry_app" "pg_exporter" {
  memory       = 64
  count        = var.enable_postgres ? 1 : 0
  name         = "tf-pgexporter-${local.name}"
  space        = var.cf_space_id
  docker_image = var.pg_exporter_image

  environment = {
    DATA_SOURCE_NAME = cloudfoundry_service_key.database_key[count.index].credentials.uri
  }

  routes {
    route = cloudfoundry_route.pg_exporter[count.index].id
  }

  labels = {
    "variant.tva/exporter" = true,
  }
  annotations = {
    "prometheus.exporter.group"    = "pg_exporter"
    "prometheus.exporter.port"     = "9187"
    "prometheus.exporter.endpoint" = "/metrics"
  }
}

resource "cloudfoundry_route" "pg_exporter" {
  count    = var.enable_postgres ? 1 : 0
  domain   = data.cloudfoundry_domain.internal.id
  space    = var.cf_space_id
  hostname = "tf-pgexporter-${local.name}"
}