# Terra Workspace Manager module

This module creates the service account and CloudSQL databases necessary for  
running the [Workspace Manager](http://github.com/databiosphere/terra-workspace-manager).  
This currently requires two postgres databases: one for the workspace manager  
itself, and one for the Stairway library used for managing sagas.

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
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| enable | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| env\_type | Environment type. Valid values are 'preview', 'preview\_shared', and 'default' | `string` | `"default"` | no |
| workspace\_project\_folder\_id | What google folder within which to create a folder for creating workspace google projects. If empty, do not create a folder. | `string` | `""` | no |
| workspace\_project\_folder\_ids | List of folder ids WSM will need to be able to access. Folders are created outside of WSM. | `list(string)` | `[]` | no |
| billing\_account\_ids | List of Google billing account ids to allow WSM to use for billing workspace google projects. | `list(string)` | `[]` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| hostname | Service hostname | `string` | `""` | no |
| db\_version | The version for the CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| db\_keepers | Whether to use keepers to re-generate instance name. | `bool` | `true` | no |
| db\_tier | The default tier (DB instance size) for the CloudSQL instance | `string` | `"db-g1-small"` | no |
| db\_name | Postgres db name | `string` | `""` | no |
| db\_user | Postgres username | `string` | `""` | no |
| stairway\_db\_name | Stairway db name | `string` | `""` | no |
| stairway\_db\_user | Stairway db username | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| sqlproxy\_sa\_id | Workspace Manager Cloud SQL Proxy Google service account ID |
| app\_sa\_id | Workspace Manager App Google service account ID |
| workspace\_container\_folder\_id | The folder id of the folder that workspace projects should be created within. |
| ingress\_ip | Workspace Manager ingress IP |
| ingress\_ip\_name | Sam ingress IP name |
| fqdn | Workspace Manager fully qualified domain name |
| cloudsql\_public\_ip | Workspace Manager CloudSQL instance IP |
| cloudsql\_instance\_name | Workspace Manager CloudSQL instance name |
| cloudsql\_root\_user\_password | Workspace Manager database root password |
| cloudsql\_app\_db\_creds | Workspace Manager database user credentials |
| cloudsql\_app\_stairway\_db\_creds | Stairway database user credentials |

