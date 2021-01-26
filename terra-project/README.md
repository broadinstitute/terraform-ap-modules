# terra-project module

This module manages non application specific resources that are applied at the project level for a terra environment.  
This module should only be used for non-application specific and non-k8s specific resources.

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
| google\_project | google project in which to create resources | `string` | n/a | yes |
| environment | the terra environment associated with a google project | `string` | n/a | yes |
| snapshot\_start\_time | Time at which daily disk snapshots are taken | `string` | `"01:00"` | no |
| snapshot\_retention\_days | Number of days to keep a snapshot, defaults to 30 for compliance | `number` | `30` | no |

## Outputs

No output.

