# See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
variable dependencies {
  type = any
  default = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}


#
# General Vars
#

variable "google_project" {
  description = "The google project"
}
variable "cluster" {
  description = "Terra GKE cluster suffix, whatever is after terra-"
}
variable "owner" {
  description = "Environment or developer"
  default = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
