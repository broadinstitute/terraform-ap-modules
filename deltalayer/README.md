# Terra Delta Layer module

This module creates infrastructure resources for Delta Layer in Terra environments.

## Requirements

No requirements.

## Release Notes

### 0.1.0
* Initial release. Creates buckets, service accounts, and applies IAM to buckets.
* Applies lifecycle rule to the "success" bucket to delete files after 120 days

### 0.2.0
* Creates pubsub topics and their IAM

### 0.3.0
* Applies uniform bucket-level access to the previously-created buckets
* Creates Postgres database

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
| db\_version | The version for the CloudSQL instance | `string` | `"POSTGRES_12"` | no |
| db\_keepers | Whether to use keepers to re-generate instance name. | `bool` | `true` | no |
| db\_tier | The default tier (DB instance size) for the CloudSQL instance | `string` | `"db-n1-standard-2"` | no |
| db\_name | Postgres db name | `string` | `"deltalayer"` | no |
| db\_user | Postgres username | `string` | `"deltalayer"` | no |
| source\_archive\_bucket | The GCS bucket containing the zip archive which contains the function | `string` | n/a | yes |
| source\_archive\_object | The source archive object (file) in archive bucket | `string` | n/a | yes |
| function\_name | A user-defined name of the function. Function names must be unique globally | `string` | n/a | yes |
| function\_description | Description of the function | `string` | `""` | no |
| function\_runtime_\mb | Memory (in MB), available to the function. Default value is 256. Possible values include 128, 256, 512, 1024, etc | `number` | 512 | no |
| function\_entry\_point | Name of the function that will be executed when the Google Cloud Function is triggered | `string` | n/a | yes |
| bq\_dataset | The user-defined BigQuery dataset for the streaming function | `string` | n/a | yes |
| bq\_tables | The BigQuery Table ID(s) that are exposed to the streaming function. Separate multiple tables by comma-delimited string | `string` | n/a | yes |
| bq\_table\_schemas | A map of key-value pairs where the key represents the Table ID and value the corresponding Table Schema in JSON format | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sa\_streamer\_id | Streamer SA ID |
| sa\_filemover\_id | File-mover SA ID |
| cloudsql\_public\_ip | Delta Layer CloudSQL instance IP |
| cloudsql\_instance\_name | Delta Layer CloudSQL instance name |
| cloudsql\_root\_user\_password | Delta Layer database root password |
| cloudsql\_app\_db\_creds | Delta Layer database user credentials |

