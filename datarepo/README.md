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
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| hostname | DNS hostname | `string` | `"data"` | no |
| dns\_zone\_name | DNS zone name | `string` | `""` | no |
| dns\_zone\_project | DNS zone project | `string` | `""` | no |
| static\_ip\_name | Name of Data Repo's static IP | `string` | n/a | yes |
| static\_ip\_project | The google project where Data Repo's static IP lives | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_ip | Datarepo ingress IP |
| fqdn | Datarepo fully qualified domain name |

