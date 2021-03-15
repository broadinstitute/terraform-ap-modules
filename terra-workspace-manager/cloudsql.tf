# Old CloudSQL instance -- will be deleted
module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.1"

  enable = var.enable && contains(["default"], var.env_type) && local.cloudsql_pg12_settings.enable

  providers = {
    google.target = google.target
  }
  project          = var.google_project
  cloudsql_name    = "${local.service}-db-${local.owner}"
  cloudsql_version = local.cloudsql_pg12_settings.version
  cloudsql_keepers = local.cloudsql_pg12_settings.keepers
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = local.service
  }
  cloudsql_tier = local.cloudsql_pg12_settings.tier

  cloudsql_replication_type = null

  app_dbs = {
    "${local.service}" = {
      db       = local.cloudsql_pg12_settings.db_name
      username = local.cloudsql_pg12_settings.db_user
    }
    "${local.service}-stairway" = {
      db       = local.cloudsql_pg12_settings.stairway_db_name
      username = local.cloudsql_pg12_settings.stairway_db_user
    }
  }

  dependencies = [var.dependencies]
}

# Postgres 13 CloudSQL instance
module "cloudsql-pg13" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=ch-DDO-1107"

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
