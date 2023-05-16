# Housekeeper Service
The **Housekeeper service** is responsible for keeping Reflex healthy.  Housekeeper routinely runs tasks to sweep away stale information from the system or make time based changes to objects in the database.

## Actions

### Flag Agents
* By default, a `poller` Agent will be flagged as `Unhealthy` for `Events Silent` if it has reported no events in 30 minutes. This can be modified by changing the value of the `REFLEX_AGENT_HEALTH_INPUT_TTL` variable.

* Agents are checked every `5` minutes by default to determine the Agent's health status. This can be modified by changing the value of the `REFLEX_AGENT_HEALTH_INPUT_INTERVAL` variable. 

### Delete/Prune Old Agents
* Housekeeper can delete Agents that have not checked in to the system based on the value set in the environment variable `REFLEX_AGENT_PRUNE_LIFETIME`.  By default, this value is set to any Agents that have not had a heartbeat in `5` days.

* Agent pruning happens every `15` minutes by default and can be changed in the `REFLEX_AGENT_PRUNE_INTERVAL` variable. 

### Lock Old Users
!!! info
    This feature is still in development

### Flag Password Change
!!! info
    This feature is still in development

## Environment Variables
* `REFLEX_HOUSEKEEPER_DISABLED` - boolean variable that determines if Housekeeper is disabled
    * *Default value: False*
* `REFLEX_HOUSEKEEPER_LOG_LEVEL` - debug log levels for Housekeeper to use during log examination (DEBUG, INFO, WARNING, ERROR, CRITICAL)
    * *Default value: ERROR*
* `REFLEX_AGENT_PRUNE_INTERVAL` - time in minutes before Housekeeper will prune Agents
    * *Default value: 15 minutes*
* `REFLEX_AGENT_PRUNE_LIFETIME` - time in days an Agent can be inactive before Housekeeper deletes it from the system
    * *Default value: 5 days*
* `REFLEX_AGENT_HEALTH_INPUT_INTERVAL` - time in minutes that an Agent's health status is checked
    * *Default value: 5 minutes*
* `REFLEX_AGENT_HEALTH_INPUT_TTL` - time in minutes before an Agent is flagged as `Events Silent`
    * *Default value: 30 minutes*










A complete list of all ReflexSOAR environment variables and their purpose can be found here: [Environment Variables](../system/environment-variables.md)