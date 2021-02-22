# Terra Delta Layer module

This module creates infrastructure resources for Delta Layer in Terra environments.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Work-around for Terraform 0.12's lack of support for 'depends\_on' in custom modules. | `any` | `[]` | no |
| enable | Enable flag for this module. If set to false, no resources will be created. | `bool` | `true` | no |
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| sourcewriter\_sa\_email | The email of the service account that will write files to the source bucket | `string` | n/a | yes |
| bucket\_suffix | Suffix to append to each bucket's name. Defaults to 'owner' variable if blank. | `string` | `""` | no |
| bucket\_location | Google region in which to create buckets | `string` | `"us-central1"` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| sa\_streamer\_id | Streamer SA ID |
| sa\_filemover\_id | File-mover SA ID |

