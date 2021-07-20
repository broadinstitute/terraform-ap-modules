# Terra Test Runner module

This module creates infrastructure resources for TestRunner in Terra environments.

## Specification

This [document](https://docs.google.com/document/d/1wP6OR9OKRK9-QZ6W2jvzjJPqfb8tlQkmm-GP-m_4rKo) describes the specific resources required for `TestRunner` to run tests and publish test results. 

## Requirements

No requirements.

## Release Notes

Not released yet.

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
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| k8s\_namespace | Terra GKE namespace suffix, whatever is after terra- | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| testrunner\_email | Test Runner Service Account email |
