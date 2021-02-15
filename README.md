<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# terraform-cloudfoundry-grafana
Deploys a Grafana instance to Cloud foundry

# Usages

Checkout the example in [examples/default](./examples/default)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| cloudfoundry | >= 0.1206.0 |

## Providers

| Name | Version |
|------|---------|
| cloudfoundry | >= 0.1206.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cf\_domain | The CF domain to use for Grafana | `string` | n/a | yes |
| cf\_org | The CF Org to deploy under | `string` | n/a | yes |
| cf\_space | The CF Space to deploy in | `string` | n/a | yes |
| db\_broker | The Database broker to use for requesting a PostgreSQL database | `string` | `"hsdp-rds"` | no |
| db\_json\_params | Optional DB JSON params | `string` | `"{}"` | no |
| db\_plan | The Database plan to use | `string` | `"postgres-micro-dev"` | no |
| disk | The amount of Disk space to allocate for Grafana (MB) | `number` | `1024` | no |
| enable\_postgres | Enable or disables postgres persistence | `bool` | `true` | no |
| environment | Environment variables for Grafana app | `map(any)` | `{}` | no |
| grafana\_image | Grafana Docker image to use | `string` | `"grafana/grafana:latest"` | no |
| memory | The amount of RAM to allocate for Grafana (MB) | `number` | `512` | no |
| name\_postfix | The postfix string to append to the hostname, prevents namespace clashes | `string` | n/a | yes |
| network\_policies | The container-to-container network policies to create with Grafana as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| grafana\_endpoint | The endpoint where Grafana is reachable on |
| grafana\_id | The Grafana's id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Contact / Getting help
andy.lo-a-foe@philips.com

# License
[License](./LICENSE.md) is MIT
