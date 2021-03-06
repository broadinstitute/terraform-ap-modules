# Terra Data Repo module

This module creates DNS records for Data Repo in Terra environments.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google.dns | n/a |
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| enable | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| datarepo\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| grafana\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| prometheus\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| dns\_zone\_name | DNS zone name | `string` | `""` | no |
| dns\_zone\_project | DNS zone project | `string` | `""` | no |
| datarepo\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| grafana\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| prometheus\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| static\_ip\_project | The google project where Data Repo's static IP lives | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_ip | Datarepo ingress IP |
| grafana\_ingress\_ip | Datarepo grafana ingress IP |
| prometheus\_ingress\_ip | Datarepo ingress IP |
| datarepo\_fqdn | Datarepo fully qualified domain name |
| grafana\_fqdn | Datarepo grafana fully qualified domain name |
| prometheus\_fqdn | Datarepo prometheus fully qualified domain name |

