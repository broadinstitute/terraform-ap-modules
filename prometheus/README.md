# Terra cluster Prometheus module

This module creates the IP, DNS and CloudArmor rules for deployments of Prometheus in Terra k8s clusters.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google.dns | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment or developer | `string` | `""` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| dns\_project | Host project for mcterra dns | `string` | `"dsp-devops"` | no |
| enable | enable prometheus server ingress reources | `bool` | `true` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_ip | Prometheus ingress IP |
| fqdn | Prometheus FQDN |

