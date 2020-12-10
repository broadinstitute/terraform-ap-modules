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
| env\_type | Environment type. Valid values are 'preview', 'preview\_shared', and 'default' | `string` | `"default"` | no |
| versions | Base64 encoded JSON string of version overrides. Used for preview environments. | `string` | `"eyJyZWxlYXNlcyI6e319Cg=="` | no |
| terra\_apps | Terra apps to enable. All disabled by default. | `map(bool)` | `{}` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| wsm\_workspace\_project\_folder\_id | What google folder within which to create a folder for creating workspace google projects. If empty, do not create a folder. | `string` | `""` | no |
| wsm\_billing\_account\_ids | List of Google billing account ids to allow WM to use for billing workspace google projects. | `list(string)` | `[]` | no |
| wsm\_db\_version | The version for the WSM CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| wsm\_db\_keepers | Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility | `bool` | `false` | no |
| grafana\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| prometheus\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| grafana\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| prometheus\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| datarepo\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| datarepo\_dns\_zone\_name | Zone where Data Repo DNS record should be provisioned | `string` | `""` | no |
| datarepo\_dns\_zone\_project | Google Project where Data Repo DNS zone lives | `string` | `""` | no |
| datarepo\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| datarepo\_static\_ip\_project | Project where of Data Repo's static IP lives | `string` | `""` | no |
| janitor\_google\_folder\_ids | List of folders Janitor has permission on. | `list(string)` | `[]` | no |
| buffer\_google\_folder\_ids | List of folders Resource Buffer Service has permission on. | `list(string)` | `[]` | no |
| buffer\_billing\_account\_ids | List of billing accounts Resource Buffer Service has permission to use. | `list(string)` | `[]` | no |
| buffer\_db\_version | The version for the Resource Buffer Service CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| buffer\_db\_keepers | Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility | `bool` | `false` | no |
| sam\_hostname | Sam ingress hostname | `string` | `"sam"` | no |
| sam\_sdk\_sa\_count | How many Sam admin SDK service accounts for GSuite group/user management to create. | `number` | `3` | no |
| sam\_firestore\_project\_name | Name for Sam Firestore project. Will default to sam-[workspace]-firestore if left blank. | `string` | `""` | no |
| sam\_firestore\_billing\_account\_id | Sam Firestore project billing account ID | `string` | `""` | no |
| sam\_firestore\_folder\_id | Sam Firestore project folder ID | `string` | `""` | no |

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
| sam\_app\_sa\_id | SAM Google service account ID |
| sam\_admin\_sdk\_sa\_ids | SAM admin SDK Google service account IDs |
| sam\_firestore\_sa\_email | Sam Firestore Google service account email |
| sam\_firestore\_project\_name | Sam Firestore project name |
| sam\_ingress\_ip | Sam ingress IP |
| sam\_ingress\_ip\_name | Sam ingress IP name |
| sam\_fqdn | Sam fully qualified domain name |
| workspace\_sqlproxy\_sa\_id | Workspace Manager Cloud SQL Proxy Google service account ID |
| workspace\_app\_sa\_id | Workspace Manager App Google service account ID |
| workspace\_cloud\_trace\_sa\_id | Workspace Manager Cloud trace Google service account ID |
| workspace\_container\_folder\_id | The folder id of the folder that workspace projects should be created within. |
| workspace\_db\_ip | Workspace Manager CloudSQL instance IP |
| workspace\_db\_instance | Workspace Manager CloudSQL instance name |
| workspace\_db\_root\_pass | Workspace Manager database root password |
| workspace\_db\_creds | Workspace Manager database user credentials |
| workspace\_stairway\_db\_creds | Stairway database user credentials |
| workspace\_ingress\_ip | Workspace Manager ingress IP |
| workspace\_ingress\_ip\_name | Workspace Manager ingress IP name |
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
| buffer\_sa\_id | Terra Resource Service Google service account ID |
| buffer\_sqlproxy\_sa\_id | Terra Resource Buffer Service Cloud SQL Proxy Google service account ID |
| buffer\_client\_sa\_id | Terra Resource Buffer Service client Google service account ID |
| buffer\_db\_ip | Terra Buffer Service CloudSQL instance IP |
| buffer\_db\_instance | Terra Buffer Service CloudSQL instance name |
| buffer\_db\_root\_pass | Terra Buffer Service database root password |
| buffer\_db\_creds | Terra Buffer Service database user credentials |
| buffer\_stairway\_db\_creds | Terra Buffer Service Stairway database user credentials |
| buffer\_ingress\_ip | Terra Buffer Service ingress IP |
| buffer\_fqdn | Terra Buffer Service fully qualified domain name |
| consent\_ingress\_ip | Static ip for consent LB |
| consent\_fqdn | fqdn to access k8s consent deployment |
| rawls\_ingress\_ip | Static ip for rawls LB |
| rawls\_fqdn | fqdn to access k8s rawls deployment |
| leonardo\_ingress\_ip | Static ip for leonardo LB |
| leonardo\_fqdn | fqdn to access k8s leonardo deployment |

