variable "parent_container" {
  type        = string
  description = "Id of the organization or folder to contain Terra resources, in the form of 'organization/[number]' or 'folders/[number]'"
}

variable "folder_display_name" {
  type        = string
  description = "Display name of the folder to create"
}
