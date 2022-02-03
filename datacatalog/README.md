# Terra Data Catalog module

This module creates the service account, DNS and CloudSQL database necessary for
running the [Terra Data Catalog](http://github.com/databiosphere/terra-data-catalog).

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google.dns"></a> [google.dns](#provider\_google.dns) | n/a |
| <a name="provider_google.target"></a> [google.target](#provider\_google.target) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudsql-pg13"></a> [cloudsql-pg13](#module\_cloudsql-pg13) | github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres | cloudsql-postgres-2.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.ingress_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_dns_record_set.ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_project_iam_member.app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.sqlproxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.app](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.sqlproxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_dns_managed_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/dns_managed_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudsql_pg13_settings"></a> [cloudsql\_pg13\_settings](#input\_cloudsql\_pg13\_settings) | Settings for Postgres 13 CloudSQL instance | `map` | `{}` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| <a name="input_cluster_short"></a> [cluster\_short](#input\_cluster\_short) | Optional short cluster name | `string` | `""` | no |
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS zone name | `string` | `"dsp-envs"` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| <a name="input_env_type"></a> [env\_type](#input\_env\_type) | Environment type. Valid values are 'preview', 'preview\_shared', and 'default' | `string` | `"default"` | no |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The google project in which to create resources | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Service hostname | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| <a name="input_subdomain_name"></a> [subdomain\_name](#input\_subdomain\_name) | Domain namespacing between zone and hostname | `string` | `""` | no |
| <a name="input_use_subdomain"></a> [use\_subdomain](#input\_use\_subdomain) | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_sa_id"></a> [app\_sa\_id](#output\_app\_sa\_id) | Terra Data Catalog App Google service account ID |
| <a name="output_cloudsql_pg13_outputs"></a> [cloudsql\_pg13\_outputs](#output\_cloudsql\_pg13\_outputs) | Terra Data Catalog CloudSQL outputs (pg13 instance) |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | Terra Data Catalog fully qualified domain name |
| <a name="output_ingress_ip"></a> [ingress\_ip](#output\_ingress\_ip) | Terra Data Catalog ingress IP |
| <a name="output_ingress_ip_name"></a> [ingress\_ip\_name](#output\_ingress\_ip\_name) | Terra Data Catalog ingress IP name |
| <a name="output_sqlproxy_sa_id"></a> [sqlproxy\_sa\_id](#output\_sqlproxy\_sa\_id) | Terra Data Catalog Cloud SQL Proxy Google service account ID |
