module "cloudsql" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=gm-enable-flags"

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

  app_dbs = {
    "${local.service}" = {
      db       = local.db_name
      username = local.db_user
    }
  }

  dependencies = [ var.dependencies ]
}
