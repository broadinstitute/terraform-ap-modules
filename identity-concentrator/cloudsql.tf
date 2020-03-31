module "cloudsql" {
  source        = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.0.0-tf-0.12"

  providers = {
    google.target =  google.target
  }
  project       = var.google_project
  cloudsql_name = "${var.service}-db-${local.owner}"
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = var.service
  }
  cloudsql_tier = var.db_tier

  app_dbs = {
    "${var.service}" = {
      db       = local.db_name
      username = local.db_user
    }
  }
}
