# Terra Env Folders

This module creates the root folder which is the top of the hierarchy under which all user space resources live in Terra.

This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
`terraform-docs markdown --no-sort . > README.md`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google.target"></a> [google.target](#provider\_google.target) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_folder.env_projects_folder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parent_container"></a> [parent\_container](#input\_parent\_container) | Id of the organization or folder to contain Terra resources, in the form of 'organization/[number]' or 'folders/[number]' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_terra_root_folder_id"></a> [terra\_root\_folder\_id](#output\_terra\_root\_folder\_id) | Root folder which is the top of the hierarchy under which all user space resources live |
