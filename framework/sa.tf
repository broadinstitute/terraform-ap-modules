#
# Application Service Accounts
#

locals {
  env_app_sas = {
    for env_sa in setproduct(keys(var.app_service_accounts), toset(var.envs)):
    "${env_sa[1]}-${env_sa[0]}" => {
      roles = var.app_service_accounts[env_sa[0]].roles
    }
  }
}
resource "google_service_account" "app" {
  for_each     = local.env_app_sas

  project      = var.google_project
  account_id   = each.key
  display_name = each.key
}

locals {
  sa_roles = flatten([
    for sa in keys(local.env_app_sas): [
      for role in local.env_app_sas[sa].roles: {
        sa = sa
        role = role
      }
    ]
  ])
}
resource "google_project_iam_member" "app" {
  for_each     = zipmap(range(length(local.sa_roles)), local.sa_roles)

  project = var.google_project
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.app[each.value.sa].email}"
}


# CI access
resource "google_service_account" "ci" {
  project      = var.google_project
  account_id   = "${local.owner}-ci-sa"
  display_name = "${local.owner}-ci-sa"
}

resource "google_project_iam_member" "ci" {
  count   = length(var.ci_sa_roles)
  project = var.google_project
  role    = element(var.ci_sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.ci.email}"
}
