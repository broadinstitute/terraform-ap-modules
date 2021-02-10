# Terra Data Repo module

This module creates infrastructure resources for Delta Layer in Terra environments.

## Requirements

No requirements.

## Resources Created

Eventually, this module will create the following resources and permissions. As of this writing, it is only creating
the three buckets, two service accounts, and applying the bucket permissions.

Resources
* 3 buckets: source, success, error
* 2 cloud functions: streamer, file-mover
* 2 service accounts: streamer, file-mover
* 1 postgres database
* 2 pubsub topics: success, error

### Permissions

Streamer service account
* runs the streamer cloud function
* reads from source bucket
* reads/writes postgres database
* publishes to success and error pubsub topics

File-mover service account
* runs the file-mover cloud function
* reads/writes source bucket
* writes success and error buckets
* subscribes to success and error pubsub topics

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
| bucket\_suffix | Suffix to append to each bucket's name. Defaults to 'owner' variable if blank. | `string` | n/a | yes |
| bucket\_location | Google region in which to create buckets | `string` | `US-CENTRAL1` | yes |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| sa\_streamer\_id | Streamer SA ID |
| sa\_filemover\_id | File-mover SA ID |
