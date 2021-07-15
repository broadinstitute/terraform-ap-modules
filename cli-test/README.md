# cli-test

This terraform module defines the resources needed for running
[CLI](https://github.com/DataBiosphere/terra-cli) tests.

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| enable-services | github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services | services-0.3.0-tf-0.12 |

## Resources

| Name | Type |
|------|------|
| google_billing_account_iam_member.cli_test_admin | resource |
| google_project.project | resource |
| google_project_iam_member.cli_test_admin | resource |
| google_service_account.cli_test_admin | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| google\_project | The google project id to create for CLI to run tests in. | `string` | n/a | yes |
| folder\_id | What folder to create google\_project in. | `string` | n/a | yes |
| billing\_account\_id | What billing account to assign google\_project. | `string` | n/a | yes |
| enable\_billing\_user | Whether to set the CLI test SA as a billing user on the billing account. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_account\_email\_admin | CLI Test Admin Google service account email |
