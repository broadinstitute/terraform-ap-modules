# Old CloudSQL instance -- will be deleted
module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.1"

  enable = var.enable && contains(["default"], var.env_type)

  providers = {
    google.target = google.target
  }
  project          = var.google_project
  cloudsql_name    = "${local.service}-db-${local.owner}"
  cloudsql_version = "POSTGRES_12"
  cloudsql_keepers = var.db_keepers
  cloudsql_instance_labels = {
    "env" = local.owner
    "app" = local.service
  }
  cloudsql_tier = "db-g1-small"

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

# New CloudSQL instance, added for Postgres 13 upgrade
module "cloudsql-red" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.1"

  enable = var.enable && contains(["default"], var.env_type)

  providers = {
    google.target = google.target
  }
  project          = var.google_project
  cloudsql_name    = "${local.service}-db-${local.owner}"
  cloudsql_version = var.db_version
  cloudsql_keepers = var.db_keepers
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
