# Agent Roles

Agents can take on several different roles that enable them to perform a variety of functions. Agents _must_ take on at least one of these roles in order to be functional.

## Default Roles
The default roles Agents can take are:

- `poller` - pulls data from defined Inputs and pushes it to ReflexSOAR in the form of an [Event](../events/index.md)
- `detector` - runs [Detection Rules](../detections/rule-types.md) against defined Inputs
- `runner`** - executes ad-hoc and playbook actions against defined resources

** _This role is still in development and provides no functionality at this time_