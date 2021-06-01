# terra-env module

This Terraform module manages resources for a single Terra environment.
Each Terra application's resources are defined in its own module that this module references.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --sort=false . > README.md`

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_agora"></a> [agora](#module\_agora) | github.com/broadinstitute/terraform-ap-modules.git//agora | agora-0.1.0 |
| <a name="module_buffer"></a> [buffer](#module\_buffer) | github.com/broadinstitute/terraform-ap-modules.git//buffer | buffer-0.3.2 |
| <a name="module_consent"></a> [consent](#module\_consent) | github.com/broadinstitute/terraform-ap-modules.git//consent | consent-0.2.0 |
| <a name="module_crl_janitor"></a> [crl\_janitor](#module\_crl\_janitor) | github.com/broadinstitute/terraform-ap-modules.git//crl-janitor | crl-janitor-0.2.9 |
| <a name="module_datarepo"></a> [datarepo](#module\_datarepo) | github.com/broadinstitute/terraform-ap-modules.git//datarepo | terra-env-0.3.8 |
| <a name="module_external_credentials_manager"></a> [external\_credentials\_manager](#module\_external\_credentials\_manager) | github.com/broadinstitute/terraform-ap-modules.git//terra-external-credentials-manager | externalcreds |
| <a name="module_firecloudorch"></a> [firecloudorch](#module\_firecloudorch) | github.com/broadinstitute/terraform-ap-modules.git//firecloudorch | firecloudorch-0.1.0 |
| <a name="module_identity_concentrator"></a> [identity\_concentrator](#module\_identity\_concentrator) | github.com/broadinstitute/terraform-ap-modules.git//identity-concentrator | identity-concentrator-0.1.2 |
| <a name="module_leonardo"></a> [leonardo](#module\_leonardo) | github.com/broadinstitute/terraform-ap-modules.git//leonardo | leonardo-0.0.1 |
| <a name="module_ontology"></a> [ontology](#module\_ontology) | github.com/broadinstitute/terraform-ap-modules.git//ontology | ontology-0.1.2 |
| <a name="module_poc_service"></a> [poc\_service](#module\_poc\_service) | github.com/broadinstitute/terraform-ap-modules.git//poc-service | poc-service-0.1.2 |
| <a name="module_rawls"></a> [rawls](#module\_rawls) | github.com/broadinstitute/terraform-ap-modules.git//rawls | rawls-0.1.0 |
| <a name="module_sam"></a> [sam](#module\_sam) | github.com/broadinstitute/terraform-ap-modules.git//sam | sam-0.3.0 |
| <a name="module_workspace_manager"></a> [workspace\_manager](#module\_workspace\_manager) | github.com/broadinstitute/terraform-ap-modules.git//terra-workspace-manager | terra-workspace-manager-0.7.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buffer_billing_account_ids"></a> [buffer\_billing\_account\_ids](#input\_buffer\_billing\_account\_ids) | List of billing accounts Resource Buffer Service has permission to use. | `list(string)` | `[]` | no |
| <a name="input_buffer_db_keepers"></a> [buffer\_db\_keepers](#input\_buffer\_db\_keepers) | Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility | `bool` | `false` | no |
| <a name="input_buffer_db_version"></a> [buffer\_db\_version](#input\_buffer\_db\_version) | The version for the Resource Buffer Service CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| <a name="input_buffer_external_folder_ids"></a> [buffer\_external\_folder\_ids](#input\_buffer\_external\_folder\_ids) | List of already existing folders that Buffer SA will get access to. | `list(string)` | `[]` | no |
| <a name="input_buffer_global_ip"></a> [buffer\_global\_ip](#input\_buffer\_global\_ip) | Whether to create a global IP address | `bool` | `false` | no |
| <a name="input_buffer_pool_names"></a> [buffer\_pool\_names](#input\_buffer\_pool\_names) | List of pools in this environment for which folders will be created and Buffer SA granted access to. | `list(string)` | `[]` | no |
| <a name="input_buffer_root_folder_id"></a> [buffer\_root\_folder\_id](#input\_buffer\_root\_folder\_id) | Parent folder under which to create all pool-specific folders. If empty, no folders will be created. | `string` | `""` | no |
| <a name="input_classic_storage_google_project"></a> [classic\_storage\_google\_project](#input\_classic\_storage\_google\_project) | The google project in which to look for a classic environment persistence layer. If empty defaults to google\_project. | `string` | `""` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| <a name="input_cluster_short"></a> [cluster\_short](#input\_cluster\_short) | Optional short cluster name | `string` | `""` | no |
| <a name="input_datarepo_dns_name"></a> [datarepo\_dns\_name](#input\_datarepo\_dns\_name) | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| <a name="input_datarepo_dns_zone_name"></a> [datarepo\_dns\_zone\_name](#input\_datarepo\_dns\_zone\_name) | Zone where Data Repo DNS record should be provisioned | `string` | `""` | no |
| <a name="input_datarepo_dns_zone_project"></a> [datarepo\_dns\_zone\_project](#input\_datarepo\_dns\_zone\_project) | Google Project where Data Repo DNS zone lives | `string` | `""` | no |
| <a name="input_datarepo_static_ip_name"></a> [datarepo\_static\_ip\_name](#input\_datarepo\_static\_ip\_name) | Name of Data Repo's static IP | `string` | `""` | no |
| <a name="input_datarepo_static_ip_project"></a> [datarepo\_static\_ip\_project](#input\_datarepo\_static\_ip\_project) | Project where of Data Repo's static IP lives | `string` | `""` | no |
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS zone name | `string` | `"dsp-envs"` | no |
| <a name="input_ecm_cloudsql_pg13_settings"></a> [ecm\_cloudsql\_pg13\_settings](#input\_ecm\_cloudsql\_pg13\_settings) | Settings for the ECM CloudSQL pg13 instance | `map` | `{}` | no |
| <a name="input_env_type"></a> [env\_type](#input\_env\_type) | Environment type. Valid values are 'preview', 'preview\_shared', and 'default' | `string` | `"default"` | no |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The google project in which to create resources | `string` | n/a | yes |
| <a name="input_grafana_dns_name"></a> [grafana\_dns\_name](#input\_grafana\_dns\_name) | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| <a name="input_grafana_static_ip_name"></a> [grafana\_static\_ip\_name](#input\_grafana\_static\_ip\_name) | Name of Data Repo's static IP | `string` | `""` | no |
| <a name="input_janitor_google_folder_ids"></a> [janitor\_google\_folder\_ids](#input\_janitor\_google\_folder\_ids) | List of folders Janitor has permission on. | `list(string)` | `[]` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| <a name="input_prometheus_dns_name"></a> [prometheus\_dns\_name](#input\_prometheus\_dns\_name) | DNS record name, excluding zone top-level domain. Eg. data.alpha | `string` | `""` | no |
| <a name="input_prometheus_static_ip_name"></a> [prometheus\_static\_ip\_name](#input\_prometheus\_static\_ip\_name) | Name of Data Repo's static IP | `string` | `""` | no |
| <a name="input_sam_firestore_billing_account_id"></a> [sam\_firestore\_billing\_account\_id](#input\_sam\_firestore\_billing\_account\_id) | Sam Firestore project billing account ID | `string` | `""` | no |
| <a name="input_sam_firestore_folder_id"></a> [sam\_firestore\_folder\_id](#input\_sam\_firestore\_folder\_id) | Sam Firestore project folder ID | `string` | `""` | no |
| <a name="input_sam_firestore_project_name"></a> [sam\_firestore\_project\_name](#input\_sam\_firestore\_project\_name) | Name for Sam Firestore project. Will default to sam-[workspace]-firestore if left blank. | `string` | `""` | no |
| <a name="input_sam_hostname"></a> [sam\_hostname](#input\_sam\_hostname) | Sam ingress hostname | `string` | `"sam"` | no |
| <a name="input_sam_sdk_sa_count"></a> [sam\_sdk\_sa\_count](#input\_sam\_sdk\_sa\_count) | How many Sam admin SDK service accounts for GSuite group/user management to create. | `number` | `3` | no |
| <a name="input_subdomain_name"></a> [subdomain\_name](#input\_subdomain\_name) | Domain namespacing between zone and hostname | `string` | `""` | no |
| <a name="input_terra_apps"></a> [terra\_apps](#input\_terra\_apps) | Terra apps to enable. All disabled by default. | `map(bool)` | `{}` | no |
| <a name="input_use_subdomain"></a> [use\_subdomain](#input\_use\_subdomain) | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| <a name="input_versions"></a> [versions](#input\_versions) | Base64 encoded JSON string of version overrides. Used for preview environments. | `string` | `"eyJyZWxlYXNlcyI6e319Cg=="` | no |
| <a name="input_wsm_billing_account_ids"></a> [wsm\_billing\_account\_ids](#input\_wsm\_billing\_account\_ids) | List of Google billing account ids to allow WM to use for billing workspace google projects. | `list(string)` | `[]` | no |
| <a name="input_wsm_buffer_pool_names"></a> [wsm\_buffer\_pool\_names](#input\_wsm\_buffer\_pool\_names) | Names of the buffer service pools that create projects for WSM. | `list(string)` | `[]` | no |
| <a name="input_wsm_cloudsql_pg13_settings"></a> [wsm\_cloudsql\_pg13\_settings](#input\_wsm\_cloudsql\_pg13\_settings) | Settings for the WSM CloudSQL pg13 instance | `map` | `{}` | no |
| <a name="input_wsm_external_folder_ids"></a> [wsm\_external\_folder\_ids](#input\_wsm\_external\_folder\_ids) | Folders that WSM needs to access other than those managed by buffer service. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_buffer_client_sa_id"></a> [buffer\_client\_sa\_id](#output\_buffer\_client\_sa\_id) | Terra Resource Buffer Service client Google service account ID |
| <a name="output_buffer_db_creds"></a> [buffer\_db\_creds](#output\_buffer\_db\_creds) | Terra Buffer Service database user credentials |
| <a name="output_buffer_db_instance"></a> [buffer\_db\_instance](#output\_buffer\_db\_instance) | Terra Buffer Service CloudSQL instance name |
| <a name="output_buffer_db_ip"></a> [buffer\_db\_ip](#output\_buffer\_db\_ip) | Terra Buffer Service CloudSQL instance IP |
| <a name="output_buffer_db_root_pass"></a> [buffer\_db\_root\_pass](#output\_buffer\_db\_root\_pass) | Terra Buffer Service database root password |
| <a name="output_buffer_fqdn"></a> [buffer\_fqdn](#output\_buffer\_fqdn) | Terra Buffer Service fully qualified domain name |
| <a name="output_buffer_ingress_ip"></a> [buffer\_ingress\_ip](#output\_buffer\_ingress\_ip) | Terra Buffer Service ingress IP |
| <a name="output_buffer_ingress_ip_name"></a> [buffer\_ingress\_ip\_name](#output\_buffer\_ingress\_ip\_name) | Terra Buffer Service ingress IP name |
| <a name="output_buffer_pool_name_to_folder_id"></a> [buffer\_pool\_name\_to\_folder\_id](#output\_buffer\_pool\_name\_to\_folder\_id) | Map from pool name to the folder that will contain all projects created for the pool. Only populated for pools in the pool\_names input variable. |
| <a name="output_buffer_sa_id"></a> [buffer\_sa\_id](#output\_buffer\_sa\_id) | Terra Resource Service Google service account ID |
| <a name="output_buffer_sqlproxy_sa_id"></a> [buffer\_sqlproxy\_sa\_id](#output\_buffer\_sqlproxy\_sa\_id) | Terra Resource Buffer Service Cloud SQL Proxy Google service account ID |
| <a name="output_buffer_stairway_db_creds"></a> [buffer\_stairway\_db\_creds](#output\_buffer\_stairway\_db\_creds) | Terra Buffer Service Stairway database user credentials |
| <a name="output_consent_fqdn"></a> [consent\_fqdn](#output\_consent\_fqdn) | fqdn to access k8s consent deployment |
| <a name="output_consent_ingress_ip"></a> [consent\_ingress\_ip](#output\_consent\_ingress\_ip) | Static ip for consent LB |
| <a name="output_crl_janitor_client_sa_id"></a> [crl\_janitor\_client\_sa\_id](#output\_crl\_janitor\_client\_sa\_id) | CRL Janitor Google service account ID |
| <a name="output_crl_janitor_db_creds"></a> [crl\_janitor\_db\_creds](#output\_crl\_janitor\_db\_creds) | CRL Janitor database user credentials |
| <a name="output_crl_janitor_db_instance"></a> [crl\_janitor\_db\_instance](#output\_crl\_janitor\_db\_instance) | CRL Janitor CloudSQL instance name |
| <a name="output_crl_janitor_db_ip"></a> [crl\_janitor\_db\_ip](#output\_crl\_janitor\_db\_ip) | CRL Janitor CloudSQL instance IP |
| <a name="output_crl_janitor_db_root_pass"></a> [crl\_janitor\_db\_root\_pass](#output\_crl\_janitor\_db\_root\_pass) | CRL Janitor database root password |
| <a name="output_crl_janitor_fqdn"></a> [crl\_janitor\_fqdn](#output\_crl\_janitor\_fqdn) | CRL Janitor fully qualified domain name |
| <a name="output_crl_janitor_ingress_ip"></a> [crl\_janitor\_ingress\_ip](#output\_crl\_janitor\_ingress\_ip) | CRL Janitor ingress IP |
| <a name="output_crl_janitor_pubsub_subscription"></a> [crl\_janitor\_pubsub\_subscription](#output\_crl\_janitor\_pubsub\_subscription) | CRL Janitor Pub/sub Subscription name |
| <a name="output_crl_janitor_pubsub_topic"></a> [crl\_janitor\_pubsub\_topic](#output\_crl\_janitor\_pubsub\_topic) | CRL Janitor Pub/sub Topic |
| <a name="output_crl_janitor_sa_id"></a> [crl\_janitor\_sa\_id](#output\_crl\_janitor\_sa\_id) | CRL Janitor Google service account ID |
| <a name="output_crl_janitor_sqlproxy_sa_id"></a> [crl\_janitor\_sqlproxy\_sa\_id](#output\_crl\_janitor\_sqlproxy\_sa\_id) | CRL Janitor Cloud SQL Proxy Google service account ID |
| <a name="output_crl_janitor_stairway_db_creds"></a> [crl\_janitor\_stairway\_db\_creds](#output\_crl\_janitor\_stairway\_db\_creds) | CRL Janitor Stairway database user credentials |
| <a name="output_firecloudorch_fqdn"></a> [firecloudorch\_fqdn](#output\_firecloudorch\_fqdn) | fqdn to acess orchestration deployment |
| <a name="output_firecloudorch_ingress_ip"></a> [firecloudorch\_ingress\_ip](#output\_firecloudorch\_ingress\_ip) | Static if for orchestration lb |
| <a name="output_fqdns"></a> [fqdns](#output\_fqdns) | Service fully qualified domain names |
| <a name="output_ic_db_creds"></a> [ic\_db\_creds](#output\_ic\_db\_creds) | Identity Concentrator database user credentials |
| <a name="output_ic_db_instance"></a> [ic\_db\_instance](#output\_ic\_db\_instance) | Identity Concentrator CloudSQL instance name |
| <a name="output_ic_db_ip"></a> [ic\_db\_ip](#output\_ic\_db\_ip) | Identity Concentrator CloudSQL instance IP |
| <a name="output_ic_db_root_pass"></a> [ic\_db\_root\_pass](#output\_ic\_db\_root\_pass) | Identity Concentrator database root password |
| <a name="output_ic_sa_id"></a> [ic\_sa\_id](#output\_ic\_sa\_id) | Identity Concentrator Google service accout ID |
| <a name="output_ingress_ips"></a> [ingress\_ips](#output\_ingress\_ips) | Service ingress IPs |
| <a name="output_leonardo_fqdn"></a> [leonardo\_fqdn](#output\_leonardo\_fqdn) | fqdn to access k8s leonardo deployment |
| <a name="output_leonardo_ingress_ip"></a> [leonardo\_ingress\_ip](#output\_leonardo\_ingress\_ip) | Static ip for leonardo LB |
| <a name="output_ontology_fqdn"></a> [ontology\_fqdn](#output\_ontology\_fqdn) | Fqdn for the ontology service |
| <a name="output_ontology_ip"></a> [ontology\_ip](#output\_ontology\_ip) | Ontology service static ip |
| <a name="output_poc_db_creds"></a> [poc\_db\_creds](#output\_poc\_db\_creds) | POC app database user credentials |
| <a name="output_poc_db_instance"></a> [poc\_db\_instance](#output\_poc\_db\_instance) | POC app CloudSQL instance name |
| <a name="output_poc_db_ip"></a> [poc\_db\_ip](#output\_poc\_db\_ip) | POC app CloudSQL instance IP |
| <a name="output_poc_db_root_pass"></a> [poc\_db\_root\_pass](#output\_poc\_db\_root\_pass) | POC app database root password |
| <a name="output_poc_fqdn"></a> [poc\_fqdn](#output\_poc\_fqdn) | POC app fully qualified domain name |
| <a name="output_poc_ingress_ip"></a> [poc\_ingress\_ip](#output\_poc\_ingress\_ip) | POC app ingress IP |
| <a name="output_poc_sa_id"></a> [poc\_sa\_id](#output\_poc\_sa\_id) | POC app Google service accout ID |
| <a name="output_rawls_fqdn"></a> [rawls\_fqdn](#output\_rawls\_fqdn) | fqdn to access k8s rawls deployment |
| <a name="output_rawls_ingress_ip"></a> [rawls\_ingress\_ip](#output\_rawls\_ingress\_ip) | Static ip for rawls LB |
| <a name="output_sam_admin_sdk_sa_ids"></a> [sam\_admin\_sdk\_sa\_ids](#output\_sam\_admin\_sdk\_sa\_ids) | SAM admin SDK Google service account IDs |
| <a name="output_sam_app_sa_id"></a> [sam\_app\_sa\_id](#output\_sam\_app\_sa\_id) | SAM Google service account ID |
| <a name="output_sam_firestore_project_name"></a> [sam\_firestore\_project\_name](#output\_sam\_firestore\_project\_name) | Sam Firestore project name |
| <a name="output_sam_firestore_sa_email"></a> [sam\_firestore\_sa\_email](#output\_sam\_firestore\_sa\_email) | Sam Firestore Google service account email |
| <a name="output_sam_fqdn"></a> [sam\_fqdn](#output\_sam\_fqdn) | Sam fully qualified domain name |
| <a name="output_sam_ingress_ip"></a> [sam\_ingress\_ip](#output\_sam\_ingress\_ip) | Sam ingress IP |
| <a name="output_sam_ingress_ip_name"></a> [sam\_ingress\_ip\_name](#output\_sam\_ingress\_ip\_name) | Sam ingress IP name |
| <a name="output_versions"></a> [versions](#output\_versions) | Base64 encoded JSON string of version overrides |
| <a name="output_workspace_app_sa_id"></a> [workspace\_app\_sa\_id](#output\_workspace\_app\_sa\_id) | Workspace Manager App Google service account ID |
| <a name="output_workspace_cloudsql_pg13_outputs"></a> [workspace\_cloudsql\_pg13\_outputs](#output\_workspace\_cloudsql\_pg13\_outputs) | Workspace Manager CloudSQL Postgres 13 instance outputs |
| <a name="output_workspace_fqdn"></a> [workspace\_fqdn](#output\_workspace\_fqdn) | Workspace Manager fully qualified domain name |
| <a name="output_workspace_ingress_ip"></a> [workspace\_ingress\_ip](#output\_workspace\_ingress\_ip) | Workspace Manager ingress IP |
| <a name="output_workspace_ingress_ip_name"></a> [workspace\_ingress\_ip\_name](#output\_workspace\_ingress\_ip\_name) | Workspace Manager ingress IP name |
| <a name="output_workspace_sqlproxy_sa_id"></a> [workspace\_sqlproxy\_sa\_id](#output\_workspace\_sqlproxy\_sa\_id) | Workspace Manager Cloud SQL Proxy Google service account ID |
