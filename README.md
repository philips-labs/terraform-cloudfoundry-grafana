<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# terraform-cloudfoundry-grafana

Deploys a Grafana instance to Cloud foundry

# Usages

Checkout the example in [examples/default](./examples/default)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| cloudfoundry | >= 0.14.1 |

## Providers

| Name | Version |
|------|---------|
| cloudfoundry | >= 0.14.1 |
| hsdp | n/a |
| random | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [cloudfoundry_app](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) |
| [cloudfoundry_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) |
| [cloudfoundry_network_policy](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) |
| [cloudfoundry_org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org) |
| [cloudfoundry_route](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) |
| [cloudfoundry_service](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) |
| [cloudfoundry_service_instance](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_instance) |
| [cloudfoundry_service_key](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_key) |
| [hsdp_config](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) |
| [hsdp_iam_client](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_client) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |
| [random_uuid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_assign\_org\_role | The default role to assign to auto signup users | `string` | `"Viewer"` | no |
| cf\_domain\_name | The CF domain to use for Grafana | `string` | `""` | no |
| cf\_org\_name | The CF Org to deploy under | `string` | n/a | yes |
| cf\_space\_id | The id of the CF Space to deploy in | `string` | n/a | yes |
| db\_broker | The Database broker to use for requesting a PostgreSQL database | `string` | `"hsdp-rds"` | no |
| db\_json\_params | Optional DB JSON params | `string` | `"{}"` | no |
| db\_plan | The Database plan to use | `string` | `"postgres-micro-dev"` | no |
| disk | The amount of Disk space to allocate for Grafana (MB) | `number` | `1024` | no |
| email\_domains | Allowed email domains for accessing Grafana | `list(string)` | <pre>[<br>  "philips.com"<br>]</pre> | no |
| enable\_postgres | Enable or disables postgres persistence | `bool` | `true` | no |
| environment | Environment variables for Grafana app | `map(any)` | `{}` | no |
| grafana\_image | Grafana Docker image to use | `string` | `"grafana/grafana:8.0.4"` | no |
| grafana\_password | The Grafana password to use | `string` | n/a | yes |
| grafana\_username | The Grafana username to use | `string` | n/a | yes |
| iam\_application\_id | The IAM application ID to create the OAuth2 client. If provided, Grafana will use IAM for authentication | `string` | `""` | no |
| memory | The amount of RAM to allocate for Grafana (MB) | `number` | `512` | no |
| name\_postfix | The postfix string to append to the hostname, prevents namespace clashes | `string` | n/a | yes |
| network\_policies | The container-to-container network policies to create with Grafana as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| oauth\_allow\_signup | Allow automatic signup when OAuth2 is enabled | `bool` | `false` | no |
| pg\_exporter\_image | n/a | `string` | `"quay.io/prometheuscommunity/postgres-exporter:latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| grafana\_database\_metrics\_app\_id | The metrics app ID |
| grafana\_database\_metrics\_endpoint | The internal metrics endpoint for the Grafana database |
| grafana\_database\_metrics\_host | The Grafana metrics internal hostname |
| grafana\_database\_metrics\_port | The Grafana metrics internal port |
| grafana\_endpoint | The endpoint where Grafana is reachable on |
| grafana\_id | The Grafana app ID |

<!--- END_TF_DOCS --->

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel

# License
[License](./LICENSE.md) is MIT
