# Postgres 13 CloudSQL instance
module "cloudsql-pg13" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.5"

  enable = var.enable && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable

  providers = {
    google.target = google.target
  }
  project          = var.google_project
  cloudsql_name    = "${local.service}-db-${local.owner}"
  cloudsql_version = local.cloudsql_pg13_settings.version
  cloudsql_keepers = local.cloudsql_pg13_settings.keepers
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = local.service
  }
  cloudsql_tier = local.cloudsql_pg13_settings.tier

  cloudsql_replication_type = null
  cloudsql_retained_backups = 28

  cloudsql_insights_config = {
    query_insights_enabled  = false,
    record_application_tags = true,
    record_client_address   = true
  }

  app_dbs = {
    "${local.service}" = {
      db       = local.cloudsql_pg13_settings.db_name
      username = local.cloudsql_pg13_settings.db_user
    }
    "${local.service}-stairway" = {
      db       = local.cloudsql_pg13_settings.stairway_db_name
      username = local.cloudsql_pg13_settings.stairway_db_user
    }
  }

  dependencies = [var.dependencies]
}
