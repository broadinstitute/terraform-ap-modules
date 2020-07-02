module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.1.0"

  enable = var.enable

  providers = {
    google.target = google.target
  }
  project       = var.google_project
  cloudsql_name = "sam-db-${local.owner}"
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = "sam"
  }
  cloudsql_tier = var.cloudsql_tier

  app_dbs = {
    "sam" = {
      db       = "sam"
      username = "sam"
    }
  }

  dependencies = [var.dependencies]
}
