module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.1"

  enable = var.enable

  providers = {
    google.target = google.target
  }
  project       = var.google_project
  cloudsql_name = "${local.service}-db-${local.owner}"
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = local.service
  }
  cloudsql_tier = var.db_tier

  cloudsql_replication_type = null

  app_dbs = {
    "${local.service}" = {
      db       = local.db_name
      username = local.db_user
    }
    "${local.service}-stairway" = {
      db       = local.stairway_db_name
      username = local.stairway_db_user
    }
  }

  dependencies = [var.dependencies]
}
