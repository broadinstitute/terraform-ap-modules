# Terra POC Service module

This module creates the service account and CloudSQL databases necessary for  
running the [Identity Concentrator service](https://github.com/DataBiosphere/healthcare-federated-access-services#identity-concentrator).

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| enable | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `any` | n/a | yes |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| db\_tier | The default tier (DB instance size) for the CloudSQL instance | `string` | `"db-g1-small"` | no |
| db\_name | Postgres db name. Defaults to ic. | `string` | `""` | no |
| db\_user | Postgres username. Defaults to ic. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_sa\_id | Identity Concentrator Google service accout ID |
| cloudsql\_public\_ip | Identity Concentrator CloudSQL instance IP |
| cloudsql\_instance\_name | Identity Concentrator CloudSQL instance name |
| cloudsql\_root\_user\_password | Identity Concentrator database root password |
| cloudsql\_app\_db\_creds | Identity Concentrator database user credentials |

