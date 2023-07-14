# Notification Channels
Reflex currently supports five types of Notification Channels.

!!! note "Creating Notification Channels for Organizations"
    As a [Global Admin](../users/index.md), you can make Notification Channels for any Organizations. However, subtenants can only create Notification Channels for their own Organization.


## Email
Notifications can be sent via Email using the following configurations:

* **Credential**: select an email credential to use
* **Send From**: address the Notification will be sent as
* **Email Subject**: subject of the Notification email
* **Email Recipients**: select who should receive the Notification
* **SMTP Server**: SMTP server to use to send the email
* **SMTP Port**: SMTP port to use to send the email
* **Use TLS**: option to use TLS to send the email

## Microsoft Teams
Notifications can be sent via the Microsoft Teams Channel using the following configurations:

* **Teams Webhook URL**: provide the webhook URL to be used to send the Notification

## Slack
Notifications can be sent via the Slack Channel using the following configurations:

* **Slack Webhook URL**: provide the webhook URL to be used to send the Notification

## PagerDuty
Notifications can be sent via the PagerDuty Channel using the following configurations:

* **Credential**: select an email credential to use
* **Default From**: email to send the incident from

## REST API
Notifications can be sent via the REST API Channel using the following configurations:

* **API URL**: provide the API URL that is supported by REST API
* **Headers**: include any header names and their value
* **POST Body**: include any data that that will be send in the POST request to the API destination

