resource "random_id" "user-password" {
  byte_length   = 16
}

resource "random_id" "root-password" {
  byte_length   = 16
}

# Cloud SQL database
module "cloudsql" {
  source        = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-0.0.1-tf-0.12"

  providers = {
    google.target =  "google"
  }
  project       = "${var.google_project}"
  cloudsql_name = "${var.cloudsql_label}-sam-db"
  cloudsql_database_name = "sam"
  cloudsql_database_user_name = "sam"
  cloudsql_database_user_password = "${random_id.user-password.hex}"
  cloudsql_database_root_password = "${random_id.root-password.hex}"
  cloudsql_instance_labels = {
    "app" = "${var.cloudsql_label}-sam"
  }
  cloudsql_tier = "${var.cloudsql_tier}"
}
