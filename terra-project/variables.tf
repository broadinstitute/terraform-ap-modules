variable "google_project" {
  type        = string
  description = "google project in which to create resources"
}

variable "environment" {
  type        = string
  description = "the terra environment associated with a google project"
}

variable "snapshot_start_time" {
  type        = string
  description = "Time at which daily disk snapshots are taken"
  default     = "01:00"
}

variable "snapshot_retention_days" {
  type        = number
  description = "Number of days to keep a snapshot, defaults to 30 for compliance"
  default     = 30
}
