# crl-test

This terraform module defines the resources needed for running
[Cloud Resource Library](https://github.com/DataBiosphere/terra-cloud-resource-lib) (CRL) integration tests.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| google\_project | The google project id to create for CRL to run integration tests within. | `string` | n/a | yes |
| folder\_id | What folder to create google\_project and a test folder under. | `string` | n/a | yes |
| billing\_account\_id | What billing account to assign to the project. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| test\_resource\_container\_folder\_id | The folder id of the folder the admin service account has permissions to edit. |
| service\_account\_email\_admin | Admin Google service account email |
| service\_account\_email\_user | User Google service account email |

