# Agents

Reflex **Agents** are responsible for digesting the data produced by Inputs (see [Inputs](../inputs/index.md) if you have not yet configured these). Agents will poll your Input for the necessary data before processing it into a format the Reflex API understands.

There are several roles that will allow Agents to perform a variety of different functions (see [Agent Roles](roles.md) for these roles and their functions).

## Creating Agents
To create new Agents in Reflex, the following procedures can be used:

1. Navigate to the `Agents` page
2. Click `New Agent`
3. Copy the Agent Pairing Token command
4. Run the command

## Creating Agent Groups
Agent Groups allow you to group Agents into collections that plugins can use to specifically target certain Inputs. With Agent Groups, each time a new Agent needs to be created, simply assign them to the appropriate Agent Group and they will inherit the necessary requirements for the specified organization. To create a new Agent Group, the following steps can be used:

1. Navigate to the Agents page
2. Click `Agent Groups`
3. Click `New Agent Group`
4. Select the desired organization
5. Give the group a relevent name
6. (Optional) Provide a brief description of the group
7. Select the inputs to be used by Agents in the group
8. (Optional) Select Agent policies if necessary
9. Click `Create`

## Agent Health Checks
The Housekeeper service will periodically run health checks against Agents to ensure they are functioning properly. If, for example, a `poller` Agent has reported no events in `x` amount of time (which is 30 minutes by default), Housekeeper will flag the Agent as `Unhealthy` due to `Events Silent`. This could indicate an issue with the Agent itself or could be due to a general lack of alerts.

Housekeeper can also prune/delete Agents that have been inactive for the defined amount of time in the `REFLEX_AGENT_PRUNE_LIFETIME` variable. By default, this is set to `7` days after the last heartbeat was detected.

More information about the Housekeeper service and how to modify the default settings can be found here: [Housekeeper Service](../services/housekeeper.md).
