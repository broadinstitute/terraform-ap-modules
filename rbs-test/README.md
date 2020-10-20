# rbs-test

This terraform module defines the resources needed for running
[Terra RBS](https://github.com/DataBiosphere/terra-rbs) integration tests.

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
| google\_project | The google project id to RBS test resources within | `string` | n/a | yes |
| billing\_account\_id | What billing account to assign to the project. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service\_account\_editor\_email | Editor permission Google service account email in RBS test |
| service\_account\_viewer\_email | Viewer permission Google service account email in RBS test |

