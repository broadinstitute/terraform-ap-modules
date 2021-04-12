# Ensure cloudbuild api is enabled
resource "google_project_service" "cloudbuild-api" {
  project = "broad-dsp-gcr-public"
  service = "cloudbuild.googleapis.com"

  provider = google.target
}

resource "google_cloudbuild_trigger" "duosui-build" {
  name        = "duosui-build"
  description = "Image build trigger for Duos UI"
  project     = "broad-dsp-gcr-public"

  # path to cloudbuild file from repo root
  filename = "cloudbuild.yml"

  github {
    owner = "DataBiosphere"
    name  = "duos-ui"

    push {
      branch = ".*"
    }
  }

  provider = google.target
}
