# Terra testrunner module

This module creates infrastructure resources for TestRunner in Terra environments.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Specification

This [document](https://docs.google.com/document/d/1wP6OR9OKRK9-QZ6W2jvzjJPqfb8tlQkmm-GP-m_4rKo) describes the specific resources required for `TestRunner` to run tests and publish test results.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google.target"></a> [google.target](#provider\_google.target) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_binding.bq_job_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.k8s_engine_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.storage_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_service_account.testrunner_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The google project in which to create resources | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_testrunner_sa_id"></a> [testrunner\_sa\_id](#output\_testrunner\_sa\_id) | Google service account id |
