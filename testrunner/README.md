# Terra Test Runner Results Reporting module

This module creates infrastructure resources for Test Runner Results Reporting in Terra environments.

## Requirements

No requirements.

## Status

In Review.

### Initial Preview
* Creates buckets, service accounts, and applies IAM to buckets.
* Applies lifecycle rule to the "success" bucket to delete files after 120 days
* Creates pubsub topics and their IAM
* Create cloud functions and their IAM

### TODOs
* Creates Test Runner Kubernetes service account and associated RBAC roles / rolebindings.

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
| testrunner\_sa\_email | The email of the Test Runner service account that will be used for all test results reporting tasks | `string` | n/a | yes |
| files\_source | The name of the google storage bucket (the string after gs://). To be used by Test Runner to temporarily store JSON files for consumption by streaming cloud function. | `string` | `""` | no |
| files\_error | The name of the google storage bucket (the string after gs://). To be used by a cloud function to store error files. | `string` | `""` | no |
| files\_success | The path of the google storage bucket (the string after gs://). To be used by a cloud function to store successfully ingested files. | `string` | `""` | no |
| files\_location | Google region in which to create buckets | `string` | `"us-central1"` | no |
| cloud\_functions\_repo | The name of the Test Runner repo that is the source of cloud functions. | `string` | `"terra-test-runner"` | no |
| bq\_dataset\_id | The ID of the BigQuery dataset for ingestion. | `string` | `"test_runner_results"` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |


## Outputs

| Name | Description |
|------|-------------|
| sa\_streamer\_id | Streamer SA ID |
| sa\_filemover\_id | File-mover SA ID |


