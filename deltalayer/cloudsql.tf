module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.2.1"

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

  app_dbs = {
    "${local.service}" = {
      db       = local.db_name
      username = local.db_user
    }
  }

  dependencies = [var.dependencies]
}

# permission for streamer SA to use cloudsql
resource "google_project_iam_member" "cloudsql" {
  provider = google.target
  project  = var.google_project
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.sa_streamer[0].email}"
}
