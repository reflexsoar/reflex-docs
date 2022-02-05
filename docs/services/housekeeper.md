# Housekeeper Service

The Housekeeper service is responsible for keeping Reflex healthy.  Housekeeper routinely runs tasks to sweep away stale information from the system or make time based changes to objects in the database

## Housekeeper Actions

### Delete Old Agents

Housekeeper can delete agents that have not checked in to the system based on the value set in the environment variable `REFLEX_AGENT_PRUNE_LIFETIME`.  By default, if not set, this will default to any Agents that have not heartbeat in `7` days.

### Lock Old Users

!!! Note
    Not Implemented Yet

### Flag Password Change

!!! Note
    Not Implemented Yet