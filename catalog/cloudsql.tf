# Postgres 13 CloudSQL instance
module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-2.0.0"

  enable = var.enable && contains(["default"], var.env_type) && local.cloudsql_settings.enable

  providers = {
    google.target = google.target
  }
  project          = var.google_project
  cloudsql_name    = "${local.service}-db-${local.owner}"
  cloudsql_version = local.cloudsql_settings.version
  cloudsql_keepers = local.cloudsql_settings.keepers
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = local.service
  }
  cloudsql_tier = local.cloudsql_settings.tier

  cloudsql_database_flags = {
    "log_checkpoints" = "on",
    "log_connections" = "on",
    "log_disconnections" = "on",
    "log_lock_waits" = "on",
    "log_min_error_statement" = "error",
    "log_temp_files" = "0",
    "log_min_duration_statement" = "-1"
  }
  cloudsql_retained_backups = 28

  cloudsql_insights_config = {
    query_insights_enabled  = false,
    record_application_tags = true,
    record_client_address   = true
  }

  app_dbs = {
    (local.service) = {
      db       = local.cloudsql_settings.db_name
      username = local.cloudsql_settings.db_user
    }
  }

  dependencies = [var.dependencies]
}
