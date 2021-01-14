# Terra Resource Buffering Service module

This module creates the service account and CloudSQL databases necessary for  
running the [terra-resource-buffer](http://github.com/databiosphere/terra-resource-buffer).

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
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| hostname | Service hostname | `string` | `""` | no |
| db\_tier | The default tier (DB instance size) for the CloudSQL instance | `string` | `"db-g1-small"` | no |
| db\_version | The version for the CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| db\_keepers | Whether to use keepers to re-generate instance name. | `bool` | `true` | no |
| db\_name | Postgres db name | `string` | `""` | no |
| db\_user | Postgres username | `string` | `""` | no |
| stairway\_db\_name | Stairway db name | `string` | `""` | no |
| stairway\_db\_user | Stairway db username | `string` | `""` | no |
| billing\_account\_ids | List of Google billing account ids to allow Resource Buffer Service to use | `list(string)` | `[]` | no |
| root\_folder\_id | Folder under which all projects will be created for this environment. If empty, no folders will be created. | `string` | `""` | no |
| pool\_names | List of pools for which folders will be created and Buffer Service Account granted access to. | `list(string)` | `[]` | no |
| external\_folder\_ids | List of already existing folders that Buffer Service Account will be granted access to. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_sa\_id | Terra Resource Buffer Service Google service accout ID |
| sqlproxy\_sa\_id | Terra Resource Buffer Service Cloud SQL Proxy Google service account ID |
| client\_sa\_id | Client Google service account ID |
| ingress\_ip | Terra Resource Buffer Service ingress IP |
| fqdn | Terra Resource Buffer Service fully qualified domain name |
| cloudsql\_public\_ip | Terra Resource Buffer Service CloudSQL instance IP |
| cloudsql\_instance\_name | Terra Resource Buffer Service CloudSQL instance name |
| cloudsql\_root\_user\_password | Terra Resource Buffer Service database root password |
| cloudsql\_app\_db\_creds | Terra Resource Buffer Service database user credentials |
| cloudsql\_app\_stairway\_db\_creds | Terra Resource Buffer Service Stairway database user credentials |
| pool\_name\_to\_folder\_id | Map from pool name to the folder that will contain all projects created for the pool. Only populated for pools in the pool\_names input variable. |

