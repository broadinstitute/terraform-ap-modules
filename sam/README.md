# Sam

This module enables the APIs and creates the service accounts needed to run the
[Sam service](https://github.com/broadinstitute/sam/).

It does not create the persistent storage resources that Sam relies on. We plan on sharing the persistent storage from the "classic" Terra deployment, so we need to distinguish between  
resources to be shared with the classic deployment and resources that are independent to new deployments.

Resources in this folder are created by the classic deployment today in dev/staging/production "shared" environments.  
To create the same resources for not-shared environments exclusive to this deployment, we need to be create the same  
resources. This module handles those resources.

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## TODO  
Need to add manual steps for GSuite service accounts. See terraform-terra repo.

Need to add Oauth Client secrets. See terraform-terra repo.  
Maybe possible in terraform now with https://github.com/terraform-providers/terraform-provider-google/issues/1287.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google.dns | n/a |
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| enable | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| env\_type | Environment type. Valid values are 'preview', 'preview\_shared', and 'default' | `string` | `"default"` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| use\_subdomain | Whether to use a subdomain between the zone and hostname | `bool` | `true` | no |
| subdomain\_name | Domain namespacing between zone and hostname | `string` | `""` | no |
| hostname | Service hostname | `string` | `""` | no |
| num\_admin\_sdk\_service\_accounts | How many Admin SDK service accounts to do GSuite group/user management to create. | `number` | `3` | no |
| firestore\_project\_name | Name for Sam Firestore project | `string` | `""` | no |
| firestore\_billing\_account\_id | Sam Firestore project billing account ID | `string` | n/a | yes |
| firestore\_folder\_id | Sam Firestore project folder ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| app\_sa\_id | Sam app Google service account ID |
| admin\_sdk\_sa\_ids | Sam admin SDK Google service account IDs |
| firestore\_sa\_email | Sam Firestore Google service account email |
| ingress\_ip | Sam ingress IP |
| ingress\_ip\_name | Sam ingress IP name |
| fqdn | Sam fully qualified domain name |
| firestore\_project\_name | Sam Firestore project name |

