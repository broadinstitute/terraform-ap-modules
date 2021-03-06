# Cloud Resource Janitor Service module

This module creates the service account and CloudSQL databases necessary for  
running the [CRL-Janitor](http://github.com/databiosphere/crl-janitor).

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
| google | n/a |
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| enable | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| google\_folder\_ids | List of folders Janitor has permission on. | `list(string)` | `[]` | no |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| hostname | Service hostname | `string` | `""` | no |
| db\_tier | The default tier (DB instance size) for the CloudSQL instance | `string` | `"db-g1-small"` | no |
| db\_name | Postgres db name | `string` | `""` | no |
| db\_user | Postgres username | `string` | `""` | no |
| stairway\_db\_name | Stairway db name | `string` | `""` | no |
| stairway\_db\_user | Stairway db username | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_sa\_id | CRL Janitor Google service accout ID |
| sqlproxy\_sa\_id | CRL Janitor Cloud SQL Proxy Google service account ID |
| client\_sa\_id | Client Google service account ID |
| ingress\_ip | CRL Janitor ingress IP |
| fqdn | CRL Janitor fully qualified domain name |
| cloudsql\_public\_ip | CRL Janitor CloudSQL instance IP |
| cloudsql\_instance\_name | CRL Janitor CloudSQL instance name |
| cloudsql\_root\_user\_password | CRL Janitor database root password |
| cloudsql\_app\_db\_creds | CRL Janitor database user credentials |
| cloudsql\_app\_stairway\_db\_creds | CRL Janitor Stairway database user credentials |
| pubsub\_topic | CRL Janitor Pub/sub topic |
| pubsub\_subscription | CRL Janitor Pub/sub subscription name |

