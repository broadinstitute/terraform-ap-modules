variable "google_project" {
  description = "The google project"
}

variable "cloudsql_label" {
  description = "Label to use to identify this cloudsql instance. Also used to name prefix."
  type = string
}

variable "cloudsql_tier" {
  default = "db-f1-micro"
  description = "The default tier (DB instance size) for Application CloudSQL instances."
}