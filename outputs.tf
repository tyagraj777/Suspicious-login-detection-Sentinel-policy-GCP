output "pubsub_topic" {
  description = "Pub/Sub topic for suspicious login alerts"
  value       = google_pubsub_topic.suspicious_login_alerts.name
}

output "custom_policy" {
  description = "Custom Sentinel policy for detecting suspicious logins"
  value       = google_securitycenter_organization_security_policy.suspicious_login_policy.display_name
}
