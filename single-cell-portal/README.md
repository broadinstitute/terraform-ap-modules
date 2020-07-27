# Terra POC Service module

This module creates the infrastructure necessary for running the
[Single Cell Portal](https://singlecell.broadinstitute.org/single_cell).

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
| random | n/a |
| google.target | n/a |
| http | n/a |
| google-beta.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| service | App name | `string` | `"singlecell"` | no |
| create\_sa | Whether to create and manage the SAs in TF or use existing ones | `bool` | `true` | no |
| app\_sa\_name | Application service account | `string` | `""` | no |
| app\_sa\_roles | Roles that the app Google service account is granted | `list(string)` | <pre>[<br>  "roles/compute.viewer",<br>  "roles/logging.logWriter",<br>  "roles/monitoring.metricWriter"<br>]</pre> | no |
| app\_read\_sa\_name | Application read service account. Defaults to singlecell-[env]-read if left blank. | `string` | `""` | no |
| app\_read\_sa\_roles | Roles that the app read Google service account is granted | `list(string)` | <pre>[<br>  "roles/storage.objectViewer"<br>]</pre> | no |
| network\_name | The network name. Defaults to singlecell | `string` | `""` | no |
| create\_network | Whether to create and manage the network in TF or use an existing one | `bool` | `true` | no |
| enable\_logging | Whether to enable logging in firewall rules | `bool` | `false` | no |
| allow\_travis | Whether to allow Travis CI runners to communicate with MongoDB | `bool` | `false` | no |
| internal\_range | Internal IP space for networks that use auto created subnets | `string` | `"10.128.0.0/9"` | no |
| corp\_range\_cidrs | Company internal network CIDRs | `list(string)` | <pre>[<br>  "69.173.64.0/19",<br>  "69.173.96.0/20",<br>  "69.173.112.0/21",<br>  "69.173.120.0/22",<br>  "69.173.124.0/23",<br>  "69.173.126.0/24",<br>  "69.173.127.0/25",<br>  "69.173.127.128/26",<br>  "69.173.127.192/27",<br>  "69.173.127.224/30",<br>  "69.173.127.228/32",<br>  "69.173.127.230/31",<br>  "69.173.127.232/29",<br>  "69.173.127.240/28"<br>]</pre> | no |
| ci\_range\_cidrs | CI/CD IPs | `list(string)` | <pre>[<br>  "35.232.118.163/32",<br>  "130.211.234.92"<br>]</pre> | no |
| gcp\_health\_check\_range\_cidrs | CI/CD IPs | `list(string)` | <pre>[<br>  "35.191.0.0/16",<br>  "130.211.0.0/22",<br>  "209.85.152.0/22",<br>  "209.85.204.0/22"<br>]</pre> | no |
| mongodb\_roles | host roles that will be present in this cluster | `list(string)` | <pre>[<br>  "primary"<br>]</pre> | no |
| mongodb\_version | n/a | `string` | `"3.6.14"` | no |
| mongodb\_user | n/a | `string` | `"single_cell"` | no |
| mongodb\_database | n/a | `string` | `"single_cell_portal_development"` | no |
| mongodb\_instance\_size | The default size of MongoDB hosts | `string` | `"n1-highmem-2"` | no |
| mongodb\_instance\_image | The default image of MongoDB hosts | `string` | `"centos-7"` | no |
| mongodb\_instance\_count\_offset | Offset at which to start naming suffix | `number` | `0` | no |
| mongodb\_instance\_group\_name | Name of mongo instance group. Defaults to singelcell-mongo-instance-group-unmanaged | `string` | `null` | no |
| mongodb\_instance\_data\_disk\_size | The default size of MongoDB data disk | `string` | `"200"` | no |
| mongodb\_instance\_data\_disk\_type | The default type of MongoDB data disk | `string` | `"pd-ssd"` | no |
| mongodb\_dns | Whether to create DNS entries | `bool` | `false` | no |
| mongodb\_extra\_flags | Extra flags passed to the mongo container. https://github.com/bitnami/bitnami-docker-mongodb#passing-extra-command-line-flags-to-mongod-startup | `string` | `null` | no |
| create\_app\_server | Whether to create & manage an app server in TF | `bool` | `false` | no |
| app\_instance\_size | The default size of app hosts | `string` | `"n1-highmem-4"` | no |
| app\_instance\_image | The default image of app hosts | `string` | `"centos-7"` | no |
| app\_instance\_data\_disk\_size | The default size of app data disk | `string` | `"100"` | no |
| app\_instance\_data\_disk\_type | The default type of app data disk | `string` | `"pd-ssd"` | no |
| create\_lb | Whether to create & manage a load balancer for the app server | `bool` | `false` | no |
| lb\_ssl\_certs | Self links of ssl certs to use for the load balancer. Required if create\_lb is true. | `list(string)` | `[]` | no |
| ssl\_policy\_name | Name of ssl cert to use for the load balancer. Defaults to singlecell-[env] | `string` | `""` | no |
| dns\_zone\_name | DNS zone name for load balancer DNS. Required if create\_lb is true. | `string` | `""` | no |
| lb\_dns\_name | DNS name for load balancer. Required if create\_lb is true. | `string` | `""` | no |
| lb\_dns\_ttl | DNS ttl for load balancer | `string` | `"300"` | no |

## Outputs

| Name | Description |
|------|-------------|
| mongodb\_instance\_public\_ips | MongoDB public IPs |
| mongodb\_instance\_private\_ips | MongoDB private IPs |
| mongodb\_instance\_names | MongoDB instance names |
| mongodb\_instance\_hostnames | MongoDB instance hostnames |
| mongodb\_instance\_priv\_hostnames | MongoDB internal hostnames |
| mongodb\_uri | MongoDB URI |
| mongodb\_priv\_uri | MongoDB internal URI |
| mongodb\_instance\_instance\_group | MongoDB instance group |
| mongodb\_config\_bucket\_name | MongoDB configuration bucket name |
| mongodb\_root\_password | MongoDB root password |
| mongodb\_app\_user | MongoDB app username |
| mongodb\_app\_password | MongoDB app password |
| app\_instance\_public\_ips | App instance public IPs |
| app\_instance\_private\_ips | App instance private IPs |
| app\_instance\_group | App instance group |
| app\_lb\_public\_ip | App load balancer public IP |

