# terra-cluster module

This Terraform module manages Terra clusters and cluster-level infrastructure configuration, such as the networks/NATs.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google-beta.target | n/a |
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| google\_project | The google project | `any` | n/a | yes |
| owner | Environment or developer | `string` | `""` | no |
| cluster\_location | k8s Vars | `string` | `"us-central1-a"` | no |
| cluster\_name | n/a | `string` | `""` | no |
| use\_short\_network\_names | Whether to use short network names for VPC/subet/etc resources | `bool` | `false` | no |
| cluster\_network | Override default name of the cluster network | `string` | `""` | no |
| cluster\_subnet | Override default name of the cluster subnet | `string` | `""` | no |
| create\_network | Whether to create a new VPC network or use an existing one | `bool` | `true` | no |
| create\_nat\_gateway | Whether to create a NAT gateway for the cluster | `bool` | `true` | no |
| auto\_create\_subnets | DEPRECATED: Let Google automatically create subnets for the GKE cluster | `bool` | `false` | no |
| nodes\_subnet\_ipv4\_cidr\_block | CIDR range for the cluster's primary subnet | `string` | `"0.0.0.0/32"` | no |
| pods\_subnet\_ipv4\_cidr\_block | Secondary CIDR range for the cluster's pods | `string` | `"0.0.0.0/32"` | no |
| services\_subnet\_ipv4\_cidr\_block | Secondary CIDR range for the cluster's services | `string` | `"0.0.0.0/32"` | no |
| private\_master\_ipv4\_cidr\_block | CIDR range for private cluster master endpoint | `string` | `"0.0.0.0/28"` | no |
| nat\_egress\_ip\_count | Number of Cloud NAT IPs to create for cluster egress | `number` | `2` | no |
| authorized\_network\_cidrs | Array of CIDR blocks for authorized networks | `list(string)` | `[]` | no |
| private\_ingress\_whitelist | List of addresses to whitelist for private ingresses | `list(object({ description = string, addresses = list(string) }))` | `[]` | no |
| cloud\_nat\_settings | Cloud NAT settings | `object({ min_ports_per_vm = number })` | <pre>{<br>  "min_ports_per_vm": 64<br>}</pre> | no |
| istio\_enable | Whether to enable Google's Istio implementation in the cluster | `bool` | `true` | no |
| release\_channel | See official documentation for GKE release channels | `string` | `"REGULAR"` | no |
| k8s\_version\_prefix | Passed to k8s-cluster module to set minimum cluster version | `string` | n/a | yes |
| node\_pool\_default | Node pool settings. Defaults are in the terraform-ap-deployments repo | <pre>object({<br>    enable     = bool,<br>    node_count = number<br>  })</pre> | n/a | yes |
| node\_pool\_highmem | n/a | <pre>object({<br>    enable     = bool,<br>    node_count = number<br>  })</pre> | n/a | yes |
| node\_pool\_default\_v2 | n/a | <pre>object({<br>    enable         = bool,<br>    min_node_count = number,<br>    max_node_count = number<br>  })</pre> | n/a | yes |
| node\_pool\_cronjob\_v1 | n/a | <pre>object({<br>    enable         = bool,<br>    min_node_count = number,<br>    max_node_count = number<br>  })</pre> | n/a | yes |
| node\_pool\_cromwell\_v1 | n/a | <pre>object({<br>    enable         = bool,<br>    min_node_count = number,<br>    max_node_count = number<br>  })</pre> | n/a | yes |
| other\_gcr\_projects | List of projects with GCR that the k8s node pool needs access to for pulling images. | `list(string)` | `[]` | no |
| notification\_channels | A list of ids for channels to contact when an alert fires | `list(string)` | `[]` | no |
| stackdriver\_workspace\_project | The stackdriver workspace that monitors the legacy firecloud environments except broad-dsde-prod. | `string` | `"broad-dsp-stackdriver"` | no |
| use\_legacy\_stackdriver\_workspace | Flag that should be enabled only if you are creating a cluster in one of the legacy firecloud gcp projects: broad-dsde-[dev/alpha/perf/staging] | `bool` | `false` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ci\_sa\_id | Google service account ID used for CI |
| egress\_ips | IPs for outgoing traffic from the cluster |

