# Terra firecloudui module

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google.dns"></a> [google.dns](#provider\_google.dns) | n/a |
| <a name="provider_google.target"></a> [google.target](#provider\_google.target) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.ingress_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_dns_record_set.ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_managed_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/dns_managed_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The google project in which to create resources | `string` | n/a | yes |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| <a name="input_cluster_short"></a> [cluster\_short](#input\_cluster\_short) | Optional short cluster name | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS zone name | `string` | `"dsp-envs"` | no |
| <a name="input_use_subdomain"></a> [use\_subdomain](#input\_use\_subdomain) | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| <a name="input_subdomain_name"></a> [subdomain\_name](#input\_subdomain\_name) | Domain namespacing between zone and hostname | `string` | `""` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Service hostname | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ingress_ip"></a> [ingress\_ip](#output\_ingress\_ip) | Firecloud UI ingress IP |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | Firecloud UI fully qualified domain name |
