resource "google_cloudbuild_trigger" "duosui-build" {
  name        = "duosui-build"
  description = "Image build trigger for Duos UI"
  project     = "broad-dsp-gcr-public"

  # path to cloudbuild file from repo root
  filename = "/build/cloudbuild.yml"

  github {
    owner = "DataBiosphere"
    name  = "duos-ui"

    push {
      branch = ".*"
    }
  }
}
