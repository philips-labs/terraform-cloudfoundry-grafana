<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# terraform-cloudfoundry-grafana

Deploys a Grafana instance to Cloud foundry

# Usages

Checkout the example in [examples/default](./examples/default)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >= 0.14.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >= 0.14.1 |
| <a name="provider_hsdp"></a> [hsdp](#provider\_hsdp) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.grafana](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_app.pg_exporter](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_network_policy.grafana](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_route.grafana](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_route.pg_exporter](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_service_instance.database](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_instance) | resource |
| [cloudfoundry_service_key.database_key](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_key) | resource |
| [hsdp_iam_client.grafana](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_client) | resource |
| [random_password.client_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_uuid.client_uuid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [cloudfoundry_domain.domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_domain.internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_org.org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org) | data source |
| [cloudfoundry_service.rds](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) | data source |
| [hsdp_config.cf](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |
| [hsdp_config.iam](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_assign_org_role"></a> [auto\_assign\_org\_role](#input\_auto\_assign\_org\_role) | The default role to assign to auto signup users | `string` | `"Viewer"` | no |
| <a name="input_cf_domain_name"></a> [cf\_domain\_name](#input\_cf\_domain\_name) | The CF domain to use for Grafana | `string` | `""` | no |
| <a name="input_cf_org_name"></a> [cf\_org\_name](#input\_cf\_org\_name) | The CF Org to deploy under | `string` | n/a | yes |
| <a name="input_cf_space_id"></a> [cf\_space\_id](#input\_cf\_space\_id) | The id of the CF Space to deploy in | `string` | n/a | yes |
| <a name="input_db_broker"></a> [db\_broker](#input\_db\_broker) | The Database broker to use for requesting a PostgreSQL database | `string` | `"hsdp-rds"` | no |
| <a name="input_db_json_params"></a> [db\_json\_params](#input\_db\_json\_params) | Optional DB JSON params | `string` | `"{}"` | no |
| <a name="input_db_plan"></a> [db\_plan](#input\_db\_plan) | The Database plan to use | `string` | `"postgres-micro-dev"` | no |
| <a name="input_disk"></a> [disk](#input\_disk) | The amount of Disk space to allocate for Grafana (MB) | `number` | `1024` | no |
| <a name="input_email_domains"></a> [email\_domains](#input\_email\_domains) | Allowed email domains for accessing Grafana | `list(string)` | <pre>[<br>  "philips.com"<br>]</pre> | no |
| <a name="input_enable_postgres"></a> [enable\_postgres](#input\_enable\_postgres) | Enable or disables postgres persistence | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment variables for Grafana app | `map(any)` | `{}` | no |
| <a name="input_grafana_image"></a> [grafana\_image](#input\_grafana\_image) | Grafana Docker image to use | `string` | `"grafana/grafana:8.1.3"` | no |
| <a name="input_grafana_password"></a> [grafana\_password](#input\_grafana\_password) | The Grafana password to use | `string` | n/a | yes |
| <a name="input_grafana_username"></a> [grafana\_username](#input\_grafana\_username) | The Grafana username to use | `string` | n/a | yes |
| <a name="input_iam_application_id"></a> [iam\_application\_id](#input\_iam\_application\_id) | The IAM application ID to create the OAuth2 client. If provided, Grafana will use IAM for authentication | `string` | `""` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of RAM to allocate for Grafana (MB) | `number` | `512` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the hostname, prevents namespace clashes | `string` | n/a | yes |
| <a name="input_network_policies"></a> [network\_policies](#input\_network\_policies) | The container-to-container network policies to create with Grafana as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| <a name="input_oauth_allow_signup"></a> [oauth\_allow\_signup](#input\_oauth\_allow\_signup) | Allow automatic signup when OAuth2 is enabled | `bool` | `false` | no |
| <a name="input_pg_exporter_image"></a> [pg\_exporter\_image](#input\_pg\_exporter\_image) | n/a | `string` | `"quay.io/prometheuscommunity/postgres-exporter:latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_database_metrics_app_id"></a> [grafana\_database\_metrics\_app\_id](#output\_grafana\_database\_metrics\_app\_id) | The metrics app ID |
| <a name="output_grafana_database_metrics_endpoint"></a> [grafana\_database\_metrics\_endpoint](#output\_grafana\_database\_metrics\_endpoint) | The internal metrics endpoint for the Grafana database |
| <a name="output_grafana_database_metrics_host"></a> [grafana\_database\_metrics\_host](#output\_grafana\_database\_metrics\_host) | The Grafana metrics internal hostname |
| <a name="output_grafana_database_metrics_port"></a> [grafana\_database\_metrics\_port](#output\_grafana\_database\_metrics\_port) | The Grafana metrics internal port |
| <a name="output_grafana_endpoint"></a> [grafana\_endpoint](#output\_grafana\_endpoint) | The endpoint where Grafana is reachable on |
| <a name="output_grafana_id"></a> [grafana\_id](#output\_grafana\_id) | The Grafana app ID |

<!--- END_TF_DOCS --->

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel

# License
[License](./LICENSE.md) is MIT
