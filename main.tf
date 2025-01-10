provider "google" {
  project = var.project_id
}

# Enable Cloud Audit Logs for Compute Engine and Cloud SQL
resource "google_project_service" "audit_logging" {
  for_each = toset([
    "compute.googleapis.com",
    "sqladmin.googleapis.com"
  ])
  service = each.value
}

# Enable required Cloud APIs for Security Command Center and Pub/Sub
resource "google_project_service" "required_services" {
  for_each = toset([
    "securitycenter.googleapis.com",
    "pubsub.googleapis.com",
    "cloudfunctions.googleapis.com"
  ])
  service = each.value
}

# Create a custom Sentinel policy for detecting suspicious login attempts
resource "google_securitycenter_organization_security_policy" "suspicious_login_policy" {
  org_id       = var.organization_id
  display_name = "Suspicious Login Detection"
  description  = "Detect failed login attempts from unusual locations or using compromised credentials."

  query = <<-EOT
    resource.type = "gce_instance"
    AND logName = "projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity"
    AND jsonPayload.authenticationInfo.principalEmail =~ ".*"
    AND jsonPayload.status.code != 0
    AND jsonPayload.resourceLocation.region NOT IN ["us-central1", "us-east1"]
  EOT
}

# Create a Pub/Sub topic for alerts
resource "google_pubsub_topic" "suspicious_login_alerts" {
  name = "suspicious-login-alerts-topic"
}

# Configure a notification channel for suspicious login attempts
resource "google_securitycenter_notification_config" "notification_config" {
  name               = "suspicious-login-notifications"
  parent             = "organizations/${var.organization_id}"
  description        = "Notifications for suspicious login attempts"
  pubsub_topic       = google_pubsub_topic.suspicious_login_alerts.id
  streaming_config {
    filter = "severity = 'HIGH' AND source_properties.policy_name = 'Suspicious Login Detection'"
  }
}

# (Optional) Cloud Function for automated response
resource "google_storage_bucket" "function_code_bucket" {
  name          = "${var.project_id}-function-code-bucket"
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "function_code" {
  name   = "respond_to_login.zip"
  bucket = google_storage_bucket.function_code_bucket.name
  source = file("respond_to_login.zip") # Ensure your code is packaged here
}

resource "google_cloudfunctions_function" "respond_to_login" {
  name        = "respond_to_suspicious_login"
  description = "Automated response to suspicious login attempts"
  runtime     = "python310"
  available_memory_mb = 128
  timeout             = 60

  source_archive_bucket = google_storage_bucket.function_code_bucket.name
  source_archive_object = google_storage_bucket_object.function_code.name
  entry_point           = "main"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.suspicious_login_alerts.name
  }
}
