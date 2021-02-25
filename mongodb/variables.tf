#
# General Vars
#
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
variable "cluster" {
  type        = string
  description = "Terra GKE cluster suffix, whatever is after terra-"
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}

variable "expose" {
  type        = bool
  description = "If true, create ingress IPs for MongoDB replicas"
  default     = false
}
variable "replica_count" {
  type        = number
  description = "Number of replicas to create ingress IPs for"
  default     = 3
}
