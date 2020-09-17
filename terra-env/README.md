# terra-env module

This Terraform module manages resources for a single Terra environment.  
Each Terra application's resources are defined in its own module that this module references.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| classic\_storage\_google\_project | The google project in which to look for a classic environment persistence layer. If empty defaults to google\_project. | `string` | `""` | no |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| preview | Preview environment flag. Set to true if creating a preview environment. | `bool` | `false` | no |
| preview\_shared | Preview environment shared resource flag. Set to true if creating a deployment for resources shared by all preview environments. | `bool` | `false` | no |
| versions | Base64 encoded JSON string of version overrides. Used for preview environments. | `string` | `"Cg=="` | no |
| terra\_apps | Terra apps to enable. All disabled by default. | `map(bool)` | `{}` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| wsm\_db\_version | The version for the WSM CloudSQL instance | `string` | `"POSTGRES_9_6"` | no |
| wsm\_db\_keepers | Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility | `bool` | `false` | no |
| datarepo\_dns\_name | Name for the Data Repo DNS record. Eg. data.alpha | `string` | `""` | no |
| datarepo\_dns\_zone\_name | Zone where Data Repo DNS record should be provisioned | `string` | `""` | no |
| datarepo\_dns\_zone\_project | Google Project where Data Repo DNS zone lives | `string` | `""` | no |
| datarepo\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| datarepo\_static\_ip\_project | Project where of Data Repo's static IP lives | `string` | `""` | no |
| janitor\_google\_folder\_id | The folder ID in which Janitor has permission to cleanup resources. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| poc\_sa\_id | POC app Google service accout ID |
| poc\_db\_ip | POC app CloudSQL instance IP |
| poc\_db\_instance | POC app CloudSQL instance name |
| poc\_db\_root\_pass | POC app database root password |
| poc\_db\_creds | POC app database user credentials |
| poc\_ingress\_ip | POC app ingress IP |
| poc\_fqdn | POC app fully qualified domain name |
| ic\_sa\_id | Identity Concentrator Google service accout ID |
| ic\_db\_ip | Identity Concentrator CloudSQL instance IP |
| ic\_db\_instance | Identity Concentrator CloudSQL instance name |
| ic\_db\_root\_pass | Identity Concentrator database root password |
| ic\_db\_creds | Identity Concentrator database user credentials |
| sam\_sa\_email | SAM Google service account email |
| sam\_admin\_sdk\_sa\_emails | SAM admin SDK Google service account emails |
| sam\_db\_ip | SAM CloudSQL instance IP |
| sam\_db\_instance | SAM CloudSQL instance name |
| sam\_db\_root\_password | SAM database root password |
| sam\_db\_creds | SAM database user credentials |
| workspace\_sqlproxy\_sa\_id | Workspace Manager Cloud SQL Proxy Google service account ID |
| workspace\_cloud\_trace\_sa\_id | Workspace Manager Cloud trace Google service account ID |
| workspace\_db\_ip | Workspace Manager CloudSQL instance IP |
| workspace\_db\_instance | Workspace Manager CloudSQL instance name |
| workspace\_db\_root\_pass | Workspace Manager database root password |
| workspace\_db\_creds | Workspace Manager database user credentials |
| workspace\_stairway\_db\_creds | Stairway database user credentials |
| workspace\_ingress\_ip | Workspace Manager ingress IP |
| workspace\_fqdn | Workspace Manager fully qualified domain name |
| crl\_janitor\_sa\_id | CRL Janitor Google service account ID |
| crl\_janitor\_sqlproxy\_sa\_id | CRL Janitor Cloud SQL Proxy Google service account ID |
| crl\_janitor\_client\_sa\_id | CRL Janitor Google service account ID |
| crl\_janitor\_db\_ip | CRL Janitor CloudSQL instance IP |
| crl\_janitor\_db\_instance | CRL Janitor CloudSQL instance name |
| crl\_janitor\_db\_root\_pass | CRL Janitor database root password |
| crl\_janitor\_db\_creds | CRL Janitor database user credentials |
| crl\_janitor\_stairway\_db\_creds | CRL Janitor Stairway database user credentials |
| crl\_janitor\_ingress\_ip | CRL Janitor ingress IP |
| crl\_janitor\_fqdn | CRL Janitor fully qualified domain name |
| crl\_janitor\_pubsub\_topic | CRL Janitor Pub/sub Topic |
| crl\_janitor\_pubsub\_subscription | CRL Janitor Pub/sub Subscription name |
| ontology\_ip | Ontology service static ip |
| ontology\_fqdn | Fqdn for the ontology service |
| versions | Base64 encoded JSON string of version overrides |
| ingress\_ips | Service ingress IPs |
| fqdns | Service fully qualified domain names |

