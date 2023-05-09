# Overview

Reflex Agents are responsible for digesting the data produced by Inputs (see [Inputs](inputs.md) if you have not yet configured these). Agents will poll your Input for the necessary data before processing it into a format the Reflex API understands.

There are several roles that will allow Agents to perform a variety of different functions (see [Agent Roles](roles.md) for these roles and their functions).

## Creating Agents
To create new Agents in Reflex, the following procedures can be used:
1. Navigate to the `Agents` page
2. Click `New Agent`
3. Copy the Agent Pairing Token command
4. Run the command

## Agent Health Checks
The Housekeeper service will periodically run health checks against Agents to ensure they are functioning properly. If, for example, a `poller` Agent has reported no events in X amount of time, Housekeeper will flag the Agent as `Unhealthy` due to `Events Silent`.

Housekeeper can also prune/delete Agents that have been inactive for the defined amount of time in the `REFLEX_AGENT_PRUNE_LIFETIME` variable. This is set to `7` days after the last heartbeat by default.

More information about the Housekeeper service can be found here: [Housekeeper Service](docs/services/housekeeper.md).
