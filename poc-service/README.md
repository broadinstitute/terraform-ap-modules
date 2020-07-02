# Terra POC Service module

This module creates the service account and CloudSQL databases necessary for  
running the [Terra POC service](https://github.com/DataBiosphere/kernel-service-poc).

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

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
| google\_project | The google project | `string` | n/a | yes |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer | `string` | `""` | no |
| db\_tier | The default tier (DB instance size) for the CloudSQL instance | `string` | `"db-g1-small"` | no |
| db\_name | Postgres db name | `string` | `""` | no |
| db\_user | Postgres username | `string` | `""` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| hostname | Service hostname | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_sa\_id | POC app Google service accout ID |
| cloudsql\_public\_ip | POC app CloudSQL instance IP |
| cloudsql\_instance\_name | POC app CloudSQL instance name |
| cloudsql\_root\_user\_password | POC app database root password |
| cloudsql\_app\_db\_creds | POC app database user credentials |
| ingress\_ip | POC app ingress IP |
| fqdn | POC app fully qualified domain name |

