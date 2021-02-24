#
# General Vars
#
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
#
variable "expose" {
  type        = bool
  description = "(Deprecated) If true, create ingress IPs for MongoDB replicas. Don't enable this outside the Terra dev environment!"
  default     = true
}
variable "replica_count" {
  type        = number
  description = "(Deprecated) Number of replicas to create ingress IPs for"
  default     = 3
}

locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
