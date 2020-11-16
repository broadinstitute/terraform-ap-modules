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
| classic\_storage\_google\_project | The google project in which to look for a classic environment persistence layer. If empty defaults to google\_project. | `string` | `""` | no |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| datarepo\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| datarepo\_dns\_zone\_name | Zone where Data Repo DNS record should be provisioned | `string` | `""` | no |
| datarepo\_dns\_zone\_project | Google Project where Data Repo DNS zone lives | `string` | `""` | no |
| datarepo\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| datarepo\_static\_ip\_project | Project where of Data Repo's static IP lives | `string` | `""` | no |
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| env\_type | Environment type. Valid values are 'preview', 'preview\_shared', and 'default' | `string` | `"default"` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| grafana\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| grafana\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| janitor\_google\_folder\_id | The folder ID in which Janitor has permission to cleanup resources. | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| prometheus\_dns\_name | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| prometheus\_static\_ip\_name | Name of Data Repo's static IP | `string` | `""` | no |
| rbs\_billing\_account\_ids | List of billing accounts RBS has permission to use. | `list(string)` | `[]` | no |
| rbs\_db\_keepers | Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility | `bool` | `false` | no |
| rbs\_db\_version | The version for the RBS CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| rbs\_google\_folder\_ids | List of folders RBS has permission on. | `list(string)` | `[]` | no |
| sam\_firestore\_billing\_account\_id | Sam Firestore project billing account ID | `string` | `""` | no |
| sam\_firestore\_folder\_id | Sam Firestore project folder ID | `string` | `""` | no |
| sam\_firestore\_project\_name | Name for Sam Firestore project. Will default to sam-[workspace]-firestore if left blank. | `string` | `""` | no |
| sam\_hostname | Sam ingress hostname | `string` | `"sam"` | no |
| sam\_sdk\_sa\_count | How many Sam admin SDK service accounts for GSuite group/user management to create. | `number` | `3` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| terra\_apps | Terra apps to enable. All disabled by default. | `map(bool)` | `{}` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| versions | Base64 encoded JSON string of version overrides. Used for preview environments. | `string` | `"eyJyZWxlYXNlcyI6e319Cg=="` | no |
| wsm\_billing\_account\_ids | List of Google billing account ids to allow WM to use for billing workspace google projects. | `list(string)` | `[]` | no |
| wsm\_db\_keepers | Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility | `bool` | `false` | no |
| wsm\_db\_version | The version for the WSM CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| wsm\_workspace\_project\_folder\_id | What google folder within which to create a folder for creating workspace google projects. If empty, do not create a folder. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| consent\_fqdn | fqdn to access k8s consent deployment |
| consent\_ingress\_ip | Static ip for consent LB |
| crl\_janitor\_client\_sa\_id | CRL Janitor Google service account ID |
| crl\_janitor\_db\_creds | CRL Janitor database user credentials |
| crl\_janitor\_db\_instance | CRL Janitor CloudSQL instance name |
| crl\_janitor\_db\_ip | CRL Janitor CloudSQL instance IP |
| crl\_janitor\_db\_root\_pass | CRL Janitor database root password |
| crl\_janitor\_fqdn | CRL Janitor fully qualified domain name |
| crl\_janitor\_ingress\_ip | CRL Janitor ingress IP |
| crl\_janitor\_pubsub\_subscription | CRL Janitor Pub/sub Subscription name |
| crl\_janitor\_pubsub\_topic | CRL Janitor Pub/sub Topic |
| crl\_janitor\_sa\_id | CRL Janitor Google service account ID |
| crl\_janitor\_sqlproxy\_sa\_id | CRL Janitor Cloud SQL Proxy Google service account ID |
| crl\_janitor\_stairway\_db\_creds | CRL Janitor Stairway database user credentials |
| fqdns | Service fully qualified domain names |
| ic\_db\_creds | Identity Concentrator database user credentials |
| ic\_db\_instance | Identity Concentrator CloudSQL instance name |
| ic\_db\_ip | Identity Concentrator CloudSQL instance IP |
| ic\_db\_root\_pass | Identity Concentrator database root password |
| ic\_sa\_id | Identity Concentrator Google service accout ID |
| ingress\_ips | Service ingress IPs |
| leonardo\_fqdn | fqdn to access k8s leonardo deployment |
| leonardo\_ingress\_ip | Static ip for leonardo LB |
| ontology\_fqdn | Fqdn for the ontology service |
| ontology\_ip | Ontology service static ip |
| poc\_db\_creds | POC app database user credentials |
| poc\_db\_instance | POC app CloudSQL instance name |
| poc\_db\_ip | POC app CloudSQL instance IP |
| poc\_db\_root\_pass | POC app database root password |
| poc\_fqdn | POC app fully qualified domain name |
| poc\_ingress\_ip | POC app ingress IP |
| poc\_sa\_id | POC app Google service accout ID |
| rawls\_fqdn | fqdn to access k8s rawls deployment |
| rawls\_ingress\_ip | Static ip for rawls LB |
| rbs\_db\_creds | Terra RBS database user credentials |
| rbs\_db\_instance | Terra RBS CloudSQL instance name |
| rbs\_db\_ip | Terra RBS CloudSQL instance IP |
| rbs\_db\_root\_pass | Terra RBS database root password |
| rbs\_fqdn | Terra RBS fully qualified domain name |
| rbs\_ingress\_ip | Terra RBS ingress IP |
| rbs\_sa\_id | Terra RBS Google service account ID |
| rbs\_sqlproxy\_sa\_id | Terra RBS Cloud SQL Proxy Google service account ID |
| rbs\_stairway\_db\_creds | Terra RBS Stairway database user credentials |
| sam\_admin\_sdk\_sa\_ids | SAM admin SDK Google service account IDs |
| sam\_app\_sa\_id | SAM Google service account ID |
| sam\_firestore\_project\_name | Sam Firestore project name |
| sam\_firestore\_sa\_email | Sam Firestore Google service account email |
| sam\_fqdn | Sam fully qualified domain name |
| sam\_ingress\_ip | Sam ingress IP |
| sam\_ingress\_ip\_name | Sam ingress IP name |
| versions | Base64 encoded JSON string of version overrides |
| workspace\_app\_sa\_id | Workspace Manager App Google service account ID |
| workspace\_cloud\_trace\_sa\_id | Workspace Manager Cloud trace Google service account ID |
| workspace\_container\_folder\_id | The folder id of the folder that workspace projects should be created within. |
| workspace\_db\_creds | Workspace Manager database user credentials |
| workspace\_db\_instance | Workspace Manager CloudSQL instance name |
| workspace\_db\_ip | Workspace Manager CloudSQL instance IP |
| workspace\_db\_root\_pass | Workspace Manager database root password |
| workspace\_fqdn | Workspace Manager fully qualified domain name |
| workspace\_ingress\_ip | Workspace Manager ingress IP |
| workspace\_sqlproxy\_sa\_id | Workspace Manager Cloud SQL Proxy Google service account ID |
| workspace\_stairway\_db\_creds | Stairway database user credentials |

