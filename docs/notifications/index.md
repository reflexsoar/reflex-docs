# Notifications
**Notifications** and **Notification Channels** provide a mechanism for ReflexSOAR to communicate with security teams outside of the ReflexSOAR platform. 

!!! note
    Notifications are currently still in the beta phase, but are functional at this time.

## Supported Channels
Reflex currently supports the following types of Notification Channels:

- [Microsoft Teams Webhook](./channels.md#microsoft-teams)
- [Slack Webhook](./channels.md#slack)
- [Email](./channels.md#slack)
- [PagerDuty Webhook](./channels.md#pagerduty)
- [REST API](channels.md#rest-api)

## Creating Notification Channels
To create a new Channel, the following steps can be used:

1. Navigate to the Notifications page
2. Click `New Channel`
3. Select the Organization you wish to use
4. Select the [Channel type](channels.md)
5. Provide a name and description for the Channel
6. Provide the necessary configuration for your Channel type
7. Provide a [message template](index.md#message-templates) for your Notifications to follow
7. Click `Create` after reviewing the configuration

## Using Notification Channels
To use Notification Channels to alert you of particular [Event](../events/index.md), an [Event Rule](../event-rules/index.md) must be created. By selecting the newly created Notification Channel for the Event Rule, you will be alerted via that Channel any time that Event Rule matches an Event.

## Message Templates
To create effective Notifications to send to your defined Channel, we recommend using [Jinja2](https://jinja.palletsprojects.com/en/3.1.x/). 

> Jinja is a fast, expressive, extensible templating engine. Special placeholders in the template allow writing code similar to Python syntax. Then the template is passed data to render the final document.




write tem in jinja will auto extract title field, severity, observables

spit out observables using markdown

auto extract data into template format and send alert

use notif channels when creating a new event rule by choosing the notif channel