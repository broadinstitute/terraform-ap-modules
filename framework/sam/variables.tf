variable "google_project" {
  description = "The google project"
}

variable "classic_storage_google_project" {
  # Today, we want to share a persistence layer between the deployment defined by this terraform and
  # broadinstitute/terraform-firecloud classic deployment. This variable is the corresponding classic deployment
  # google project.
  description = "The google project outside of the cluster that has storage."
}

# Should be the same bucket as used by equivalent classic deployment.
variable "google_key_cache_bucket" {
  description = "The bucket for Sam's Google Key Cache for storing pet service account keys."
  type = object({
    # The name of the bucket.
    # https://github.com/broadinstitute/firecloud-develop/blob/18384f1d51b6ae231bc6d2ad52d7904d6c5c3387/base-configs/sam/sam.conf.ctmpl#L82
    name = string
    # The name of the google project the bucket is in.
    project = string
  })
}

variable "gcp_name_prefix" {
  description = "The string to prefix to GCP names to make them unique across different instantiations of this module."
}

variable "num_admin_sdk_service_accounts" {
  description = "How many Admin SDK service accounts to do GSuite group/user management to create."
  type = number
}
