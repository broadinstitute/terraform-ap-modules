# Terra testrunner module

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown . > README.md`

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
| [google_project_iam_member.firecloud_sa_project_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.leonardo_sa_project_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.sam_sa_project_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.testrunner_cf_deployer_sa_project_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.testrunner_sa_project_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.testrunner_streamer_sa_project_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_pubsub_topic.testrunner_results_bucket_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_member.gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_member) | resource |
| [google_service_account.testrunner_cf_deployer_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.testrunner_dashbaord_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.testrunner_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.testrunner_streamer_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.testrunner_cf_deployer_sa_runas_default_appspot_sa_service_account_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.testrunner_cf_deployer_sa_runas_testrunner_streamer_sa_service_account_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.testrunner_dashboard_workload_identity_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket.testrunner-results-bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.testrunner_streamer_sa_storage_bucket_iam_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_notification.testrunner-results-finalize-notification](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_notification) | resource |
| [google_app_engine_default_service_account.default_appspot_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/app_engine_default_service_account) | data source |
| [google_service_account.firecloud_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |
| [google_service_account.leonardo_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |
| [google_service_account.sam_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |
| [google_storage_project_service_account.gsp_automatic_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | Google region in which to create buckets | `string` | `"us-central1"` | no |
| <a name="input_dashboard_namespace"></a> [dashboard\_namespace](#input\_dashboard\_namespace) | The Kubernetes namespace of the TestRunner Dashboard | `string` | `"testrunnerdashboard"` | no |
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| <a name="input_enable_dashboard"></a> [enable\_dashboard](#input\_enable\_dashboard) | Enable flag for TestRunner dashboard. If set to false, no resources related to TestRunner dashboard will be created. | `bool` | `false` | no |
| <a name="input_firecloud_sa_name"></a> [firecloud\_sa\_name](#input\_firecloud\_sa\_name) | n/a | `string` | `""` | no |
| <a name="input_firecloud_sa_project_iam_roles"></a> [firecloud\_sa\_project\_iam\_roles](#input\_firecloud\_sa\_project\_iam\_roles) | A list of one or more roles to which the Firecloud SA will be added. | `list(string)` | <pre>[<br>  "roles/storage.admin"<br>]</pre> | no |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The google project in which to create resources | `string` | n/a | yes |
| <a name="input_gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_roles"></a> [gsp\_automatic\_sa\_testrunner\_results\_bucket\_pubsub\_topic\_publish\_iam\_roles](#input\_gsp\_automatic\_sa\_testrunner\_results\_bucket\_pubsub\_topic\_publish\_iam\_roles) | A list of one or more roles which the GSP Automatic SA will use to publish results to the TestRunner Results Bucket Topic. | `list(string)` | <pre>[<br>  "roles/pubsub.publisher"<br>]</pre> | no |
| <a name="input_leonardo_sa_name"></a> [leonardo\_sa\_name](#input\_leonardo\_sa\_name) | n/a | `string` | `""` | no |
| <a name="input_leonardo_sa_project_iam_roles"></a> [leonardo\_sa\_project\_iam\_roles](#input\_leonardo\_sa\_project\_iam\_roles) | A list of one or more roles to which the Leonardo SA will be added. | `list(string)` | <pre>[<br>  "roles/storage.admin"<br>]</pre> | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| <a name="input_sam_sa_name"></a> [sam\_sa\_name](#input\_sam\_sa\_name) | n/a | `string` | `""` | no |
| <a name="input_sam_sa_project_iam_roles"></a> [sam\_sa\_project\_iam\_roles](#input\_sam\_sa\_project\_iam\_roles) | A list of one or more roles to which the Sam SA will be added. | `list(string)` | <pre>[<br>  "roles/storage.admin"<br>]</pre> | no |
| <a name="input_testrunner_cf_deployer_sa_project_iam_roles"></a> [testrunner\_cf\_deployer\_sa\_project\_iam\_roles](#input\_testrunner\_cf\_deployer\_sa\_project\_iam\_roles) | A list of one or more roles to which the TestRunner Cloud Function Deployer SA will be added. | `list(string)` | <pre>[<br>  "roles/cloudfunctions.admin"<br>]</pre> | no |
| <a name="input_testrunner_sa_project_iam_roles"></a> [testrunner\_sa\_project\_iam\_roles](#input\_testrunner\_sa\_project\_iam\_roles) | A list of one or more roles to which the TestRunner SA will be added. | `list(string)` | <pre>[<br>  "roles/bigquery.user",<br>  "roles/container.viewer",<br>  "roles/storage.admin"<br>]</pre> | no |
| <a name="input_testrunner_streamer_sa_project_iam_roles"></a> [testrunner\_streamer\_sa\_project\_iam\_roles](#input\_testrunner\_streamer\_sa\_project\_iam\_roles) | A list of one or more project roles to which the TestRunner Streamer SA will be added. | `list(string)` | <pre>[<br>  "roles/bigquery.user"<br>]</pre> | no |
| <a name="input_testrunner_streamer_sa_storage_bucket_iam_roles"></a> [testrunner\_streamer\_sa\_storage\_bucket\_iam\_roles](#input\_testrunner\_streamer\_sa\_storage\_bucket\_iam\_roles) | A list of one or more storage bucket roles to which the TestRunner Streamer SA will be added. | `list(string)` | <pre>[<br>  "roles/storage.admin"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_testrunner_cf_deployer_sa_id"></a> [testrunner\_cf\_deployer\_sa\_id](#output\_testrunner\_cf\_deployer\_sa\_id) | TestRunner Cloud Functions deployer service account id |
| <a name="output_testrunner_dashboard_sa_id"></a> [testrunner\_dashboard\_sa\_id](#output\_testrunner\_dashboard\_sa\_id) | TestRunner Dashboard Workload Identity service account id |
| <a name="output_testrunner_sa_id"></a> [testrunner\_sa\_id](#output\_testrunner\_sa\_id) | TestRunner service account id |
| <a name="output_testrunner_streamer_sa_id"></a> [testrunner\_streamer\_sa\_id](#output\_testrunner\_streamer\_sa\_id) | TestRunner streamer service account id |
