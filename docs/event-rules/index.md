# Event Rules

## What are Event Rules?
Event Rules are a method for applying automation to new or old Events in the system.  Event Rules use Reflex Query Language to match rules in flight and then execute an action on matching events.

## Configuring an Event Rule
To configure an Event Rule follow the guide below:

1. Click Events
2. Click Event Rules
3. Select New Event Rule
4. Enter all the required information for the Rule (see Event Rule Properties for more detail on what each property does)
5. Test the Rule
6. Save the Rule


## Event Rule Properties

- **Global Rule** - Global Rules exist in the Default Tenant and will apply to every tenant in the Reflex system. Matches on Global rules do not stop further rule processing.
- **Run rule retroactively after creation** - When the rule is saved, Reflex will retroactively attempt to match this rule to any event that is currently in a New state
- **Priority** - The Event Rule priority controls which Event Rules will be be processed first.  Lower priority rules are processed first, this is useful for chaining Event Rules in a very specific order.
- **Expiration** - Rules can be temporary and set to expire, e.g. an Event is noisy and needs to be ignored temporarily