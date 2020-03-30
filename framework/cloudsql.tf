locals {
  env_psql_app_dbs = {
    for env_db in setproduct(keys(var.postgres_app_dbs), toset(var.envs)):
    "${env_db[1]}-${env_db[0]}" => {
      db = "${env_db[1]}-${var.postgres_app_dbs[env_db[0]]["db"]}"
      username = "${env_db[1]}-${var.postgres_app_dbs[env_db[0]]["username"]}"
    }
  }
}

# Cloud SQL database
module "cloudsql" {
  source        = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloudsql-postgres?ref=cloudsql-postgres-1.0.0-tf-0.12"

  providers = {
    google.target =  google.target
  }
  project       = var.google_project
  cloudsql_name = "${local.cluster_name}-db"
  cloudsql_instance_labels = {
    "cluster" = local.cluster_name
  }
  cloudsql_tier = var.cloudsql_tier

  app_dbs = local.env_psql_app_dbs
}
