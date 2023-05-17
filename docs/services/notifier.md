# Notifier
**Notifier** is the service that handles all forms of Notification activity. It can send webhooks, emails, and more, on behalf of the Reflex system. For example, Notifier can send an email to a user when a case is assigned to them. 

!!! note
    Notifier's sole purpose is to send Notifications.


## Environment Variables

* `DISABLED` - boolean variable that defines if Notifier is enabled or not
    * *Default value: False*

* `LOG_LEVEL` - debug log levels for Notifier to use (DEBUG, INFO, WARNING, ERROR, CRITICAL)
    * *Default value: ERROR*

* `MAX_THREADS` - determines the max number of threads Notifier can use
    * *Default value: 1*

* `POLL_INTERVAL`: the interval in which Notifier will poll for pending Notifications
    * *Default value: 30 seconds*
