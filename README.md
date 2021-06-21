<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# terraform-cloudfoundry-grafana

Deploys a Grafana instance to Cloud foundry

# Usages

Checkout the example in [examples/default](./examples/default)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                              | Version   |
| --------------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)          | >= 0.14.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement_cloudfoundry) | >= 0.14.1 |

## Providers

| Name                                                                        | Version   |
| --------------------------------------------------------------------------- | --------- |
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider_cloudfoundry) | >= 0.14.1 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                         | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [cloudfoundry_app.grafana](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app)                            | resource    |
| [cloudfoundry_app.pg_exporter](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app)                        | resource    |
| [cloudfoundry_network_policy.grafana](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy)      | resource    |
| [cloudfoundry_route.grafana](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route)                        | resource    |
| [cloudfoundry_route.pg_exporter](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route)                    | resource    |
| [cloudfoundry_service_instance.database](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_instance) | resource    |
| [cloudfoundry_service_key.database_key](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_key)       | resource    |
| [cloudfoundry_domain.domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain)                    | data source |
| [cloudfoundry_domain.internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain)                  | data source |
| [cloudfoundry_org.org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org)                             | data source |
| [cloudfoundry_service.rds](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service)                     | data source |

## Inputs

| Name                                                                                 | Description                                                                          | Type                                                                                                  | Default                                                  | Required |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------- | :------: |
| <a name="input_cf_domain"></a> [cf_domain](#input_cf_domain)                         | The CF domain to use for Grafana                                                     | `string`                                                                                              | n/a                                                      |   yes    |
| <a name="input_cf_org"></a> [cf_org](#input_cf_org)                                  | The CF Org to deploy under                                                           | `string`                                                                                              | n/a                                                      |   yes    |
| <a name="input_cf_space_id"></a> [cf_space_id](#input_cf_space_id)                   | The id of the CF Space to deploy in                                                  | `string`                                                                                              | n/a                                                      |   yes    |
| <a name="input_db_broker"></a> [db_broker](#input_db_broker)                         | The Database broker to use for requesting a PostgreSQL database                      | `string`                                                                                              | `"hsdp-rds"`                                             |    no    |
| <a name="input_db_json_params"></a> [db_json_params](#input_db_json_params)          | Optional DB JSON params                                                              | `string`                                                                                              | `"{}"`                                                   |    no    |
| <a name="input_db_plan"></a> [db_plan](#input_db_plan)                               | The Database plan to use                                                             | `string`                                                                                              | `"postgres-micro-dev"`                                   |    no    |
| <a name="input_disk"></a> [disk](#input_disk)                                        | The amount of Disk space to allocate for Grafana (MB)                                | `number`                                                                                              | `1024`                                                   |    no    |
| <a name="input_enable_postgres"></a> [enable_postgres](#input_enable_postgres)       | Enable or disables postgres persistence                                              | `bool`                                                                                                | `true`                                                   |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                   | Environment variables for Grafana app                                                | `map(any)`                                                                                            | `{}`                                                     |    no    |
| <a name="input_grafana_image"></a> [grafana_image](#input_grafana_image)             | Grafana Docker image to use                                                          | `string`                                                                                              | `"grafana/grafana:8.0.3"`                                |    no    |
| <a name="input_grafana_password"></a> [grafana_password](#input_grafana_password)    | The Grafana password to use                                                          | `string`                                                                                              | n/a                                                      |   yes    |
| <a name="input_grafana_username"></a> [grafana_username](#input_grafana_username)    | The Grafana username to use                                                          | `string`                                                                                              | n/a                                                      |   yes    |
| <a name="input_memory"></a> [memory](#input_memory)                                  | The amount of RAM to allocate for Grafana (MB)                                       | `number`                                                                                              | `512`                                                    |    no    |
| <a name="input_name_postfix"></a> [name_postfix](#input_name_postfix)                | The postfix string to append to the hostname, prevents namespace clashes             | `string`                                                                                              | n/a                                                      |   yes    |
| <a name="input_network_policies"></a> [network_policies](#input_network_policies)    | The container-to-container network policies to create with Grafana as the source app | <pre>list(object({<br> destination_app = string<br> protocol = string<br> port = string<br> }))</pre> | `[]`                                                     |    no    |
| <a name="input_pg_exporter_image"></a> [pg_exporter_image](#input_pg_exporter_image) | n/a                                                                                  | `string`                                                                                              | `"quay.io/prometheuscommunity/postgres-exporter:latest"` |    no    |

## Outputs

| Name                                                                                                                                   | Description                                            |
| -------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| <a name="output_grafana_database_metrics_app_id"></a> [grafana_database_metrics_app_id](#output_grafana_database_metrics_app_id)       | The metrics app ID                                     |
| <a name="output_grafana_database_metrics_endpoint"></a> [grafana_database_metrics_endpoint](#output_grafana_database_metrics_endpoint) | The internal metrics endpoint for the Grafana database |
| <a name="output_grafana_database_metrics_host"></a> [grafana_database_metrics_host](#output_grafana_database_metrics_host)             | The Grafana metrics internal hostname                  |
| <a name="output_grafana_database_metrics_port"></a> [grafana_database_metrics_port](#output_grafana_database_metrics_port)             | The Grafana metrics internal port                      |
| <a name="output_grafana_endpoint"></a> [grafana_endpoint](#output_grafana_endpoint)                                                    | The endpoint where Grafana is reachable on             |
| <a name="output_grafana_id"></a> [grafana_id](#output_grafana_id)                                                                      | The Grafana app ID                                     |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Contact / Getting help

andy.lo-a-foe@philips.com

# License

[License](./LICENSE.md) is MIT
