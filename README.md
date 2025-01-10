# Suspicious-login-detection-Sentinel-policy-GCP
Detailed implementation plan to detect and respond to suspicious login attempts using Terraform. This includes enabling Cloud Audit Logs, creating a Sentinel policy, and configuring alerts and automated responses.


# Suspicious Login Detection and Response

## Overview
This project sets up a detection system for suspicious login attempts to Google Cloud resources. It uses Cloud Audit Logs, Sentinel policies, and Pub/Sub for alerting and Cloud Functions for automated response actions.

---

## Features
- **Audit Logging:** Monitors Compute Engine and Cloud SQL for suspicious login attempts.
- **Sentinel Policy:** Custom logic to detect failed login attempts from unusual regions or using compromised credentials.
- **Alerting:** Sends notifications to a Pub/Sub topic for violations.
- **Automated Response:** Cloud Function that responds to suspicious login attempts.

---

## Prerequisites
1. **Google Cloud Project and Organization**: Ensure you have a GCP project and organization set up.
2. **Terraform Installed**: Install Terraform from [Terraform.io](https://www.terraform.io/downloads).
3. **Cloud Function Code**: Package your Cloud Function code (Python or Node.js) into a ZIP file and save it as `respond_to_login.zip`.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd suspicious-login-detection



Testing Consideration**


Test Detection

1. Simulate a failed login attempt from an unusual region.

3. Check the Security Command Center for findings.

Test Notification

1. Verify that a message is published to the Pub/Sub topic.

3. Check that the Cloud Function responds to the alert.

Security Considerations

1. Access Control: Ensure least privilege for all service accounts and roles.

2. MFA Enforcement: Enable multi-factor authentication for all user accounts.

3. Policy Validation: Test and validate the Sentinel policy to avoid false positives.


Troubleshooting

1. No Findings Triggered: Verify that Cloud Audit Logs are enabled and log entries match the policy query.

2. Notifications Not Delivered: Check Pub/Sub permissions and configurations.
  
3. Cloud Function Not Triggered: Ensure the function's event trigger is correctly linked to the Pub/Sub topic.


Resources

-Google Security Command Center Documentation

-Cloud Audit Logs Documentation

-Terraform Google Provider


