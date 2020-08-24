# janitor-test

This terraform module defines the resources needed for running
[Terra Resource Janitor](https://github.com/DataBiosphere/terra-resource-janitor) integration tests.

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| google\_project | The google project id to create for Janitor to run integration tests within. | `string` | n/a | yes |
| folder\_id | What folder to create google\_project under. | `string` | n/a | yes |
| billing\_account\_id | What billing account to assign to the project. | `string` | n/a | yes |

## Outputs

No output.

