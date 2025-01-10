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
