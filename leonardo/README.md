# Terra leonardo module

For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)  
and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

The following providers are used by this module:

- google.dns

- google.target

## Required Inputs

The following input variables are required:

### cluster

Description: Terra GKE cluster suffix, whatever is after terra-

Type: `string`

### google\_project

Description: The google project in which to create resources

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### cluster\_short

Description: Optional short cluster name

Type: `string`

Default: `""`

### dependencies

Description: Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules.

Type: `any`

Default: `[]`

### dns\_zone\_name

Description: DNS zone name

Type: `string`

Default: `"dsp-envs"`

### enable

Description: Enable flag for this module. If set to false, no resources will be created.

Type: `bool`

Default: `true`

### hostname

Description: Service hostname

Type: `string`

Default: `""`

### owner

Description: Environment or developer. Defaults to TF workspace name if left blank.

Type: `string`

Default: `""`

### subdomain\_name

Description: Domain namespacing between zone and hostname

Type: `string`

Default: `""`

### use\_subdomain

Description: Whether to use a subdomain between the zone and hostname

Type: `bool`

Default: `true`

## Outputs

The following outputs are exported:

### fqdn

Description: Leonardo fully qualified domain name

### ingress\_ip

Description: Leonardo ingress IP

