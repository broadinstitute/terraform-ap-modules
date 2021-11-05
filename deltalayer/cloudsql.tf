module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.6"

  count = var.enable ? 1 : 0

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
  }

  dependencies = [var.dependencies]
}

# permission for streamer SA to use cloudsql. N.B. we do not create a separate sqlproxy SA, since
# Cloud Functions are the only sql client as of this writing. In the future, if we move to standalone
# services accessing this SQL instance, we may want to create a new sqlproxy SA.
resource "google_project_iam_member" "cloudsql" {
  provider = google.target
  project  = var.google_project
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.sa_streamer[0].email}"
}
