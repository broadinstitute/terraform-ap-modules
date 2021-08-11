resource "kubernetes_service_account" "testrunner_k8s_service_account" {
  metadata {
    name      = "${local.service}-k8s-sa"
    namespace = var.k8s_namespace
    labels = {
      "app.kubernetes.io/component" = local.service
    }
  }
}

resource "kubernetes_role" "testrunner_k8s_role" {
  metadata {
    name      = "${local.service}-k8s-role"
    namespace = var.k8s_namespace
    labels = {
      "app.kubernetes.io/component" = local.service
    }
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/exec"]
    verbs      = ["get", "list", "watch", "delete", "patch", "create", "update"]
  }
  rule {
    api_groups     = [""]
    resources      = ["configmaps"]
    resource_names = ["terra-component-version"]
    verbs          = ["get", "patch", "update"]
  }
  rule {
    api_groups = ["extensions", "apps"]
    resources  = ["deployments", "deployments/scale"]
    verbs      = ["get", "list", "watch", "delete", "patch", "create", "update"]
  }
}

resource "kubernetes_role_binding" "testrunner_k8s_sa_rolebinding" {
  metadata {
    name      = "${local.service}-k8s-sa-rolebinding"
    namespace = var.k8s_namespace
    labels = {
      "app.kubernetes.io/component" = local.service
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.testrunner_k8s_role.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.testrunner_k8s_service_account.metadata[0].name
    namespace = var.k8s_namespace
  }
  depends_on = [
    kubernetes_role.testrunner_k8s_role,
    kubernetes_service_account.testrunner_k8s_service_account
  ]
}

data "kubernetes_secret" "testrunner_k8s_sa_secret" {
  metadata {
    name      = kubernetes_service_account.testrunner_k8s_service_account.default_secret_name
    namespace = var.k8s_namespace
  }
  depends_on = [
    kubernetes_service_account.testrunner_k8s_service_account
  ]
}
