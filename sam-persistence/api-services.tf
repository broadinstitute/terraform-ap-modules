module "enable-services" {
  source      = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"
  enable_flag = "1"
  providers = {
    google.target = google.target
  }
  project = var.google_project
  services = [
    # Sam uses KMS to create a key with access for all users used by Cromwell to get images.
    "cloudkms.googleapis.com",
    # Sam uses datastore to implement distributed locking around modifications to data stored in buckets.
    "datastore.googleapis.com",
    # Sam uses pubsub to communicate with itself about sync google groups and to get notifications about deleted
    # objects in its managed buckets.
    "pubsub.googleapis.com",
    # Sam uses sql to store most of its data.
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    # Sam uses google bucket to store pet service account keys.
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
  ]
}
