module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-2.0.0"

  enable = var.enable

  providers = {
    google.target = google.target
  }
  project          = var.google_project

  cloudsql_name    = "${local.service}-db-${local.owner}"
  cloudsql_version = var.db_version
  cloudsql_keepers = var.db_keepers
  cloudsql_tier    = var.db_tier
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = local.service
  }

  cloudsql_replication_type = null
  
  cloudsql_database_flags = {
    "log_checkpoints" = "on",
    "log_connections" = "on",
    "log_disconnections" = "on",
    "log_lock_waits" = "on",
    "log_min_error_statement" = "error",
    "log_temp_files" = "0",
    "log_min_duration_statement" = "-1"
  }

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
