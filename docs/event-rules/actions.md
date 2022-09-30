# Actions

Event Rule actions allow an analyst to apply reactive actions to any Event that matches an Event Rules Query (RQL) criteria.

## Supported Actions

!!! note
    Multiple actions are supported, .e.g an event can be tagged and moved into a case at the same time

- **Merge in to Case** - Pushes all matching events to the selected case
- **Dismiss** - Dismisses the event with the selected Reason and can add a comment to go along with the dismissal
- **Tag** - Add one or more tags to the event
- **Change Severity** - Elevate or lower the severity of the event
- **Create new Case** - Create a new case for each matched event and optionally apply a case template