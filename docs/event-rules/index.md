# Event Rules
**Event Rules** are a method for applying automation to new or old [Events](../events/index.md) in the system. Event Rules use [Reflex Query Language (RQL)](../rql/index.md) to match Rules in flight and then execute an action on matching events.

## Creating Event Rules
To create a new Event Rule, the following steps can be used:

1. Navigate to the Event Rules page
2. Click `New Event Rule`
3. Enter details, expiration, and query for the Rule
4. Click `Test Rule` to test the Rule
5. Determine Event actions, Case actions, and notifications
6. Review the Event Rule
7. Click `Create`

## Editing Event Rules
To modify an Event Rule after creation, the following steps can be used:

1. Navigate to the Event Rules page
2. Locate the Event Rule you wish to edit
3. Click `Manage`
4. Click `Edit Rule`

!!! note "Disabling Rules"
    In the event a Rule needs to be disabled, click `Manage` and then `Disable Rule`, or toggle the *Active* switch to `NO` when editing the Rule.

## Configuring Event Rules
### *Rule Details*

* **Organization**: select the appropriate Organization to apply the Rule to
* **Rule Name**: give the Rule a relevant name
* **Rule Description**: provide a description of the Rule and its purpose
* **Active**: Rule is actively run against Events
* **Protected**: Rule can only be edited and disabled by its creator
* **Run Retroactive**: Rule runs retroactively when saved, meaning Reflex will attempt to match the Rule to any event that is in the `New` state
* **Global Rule**: exist in the Default Tenant and will apply to every tenant in the Reflex instance
* **Priority**: determines which Event Rules will be processed first

!!! note "Priority"
    Rules with a lower numbered priority will run first, whereas Rules with a high priority number will run after.

### *Expiration*
* **Expire**: a Rule will automatically disabled itself after `x` number of days (`1` is the default)

### *Event Query*
* **Query**: provide an [RQL query](../rql/index.md) to match events to this rule based on a certain criteria
* **Number of Test Events**: Reflex will fetch the last `x` number of events and compare this rule to them (see [Testing](testing.md) for best testing practices)
* **Start Time**: start of the search period to test the Rule against
* **End Time**: end of the search period to test the Rule against
* **Include Results**: will present all matched Events in a new window

!!! info "Testing Queries"
    When testing RQL queries, Reflex will display one of three banners: `Query matched x Events`, `Invalid RQL query`, or `Query did not match target Event. Try increasing the number of test events or increasing your date range`.

### *Event Actions*
See [Event Actions](actions.md)

### *Case Actions*
See [Event Actions](actions.md)

### *Notifications*
* Notification Channel: any time Rule matches an Event, a notification will be sent to all selected channels using the channels defined message template

!!! note "No Notification Channel Selected"
    You do not *have to* select a Notification Channel for Event Rules.

### *Review*
Once you have reviewed the Event Rule, click `Create`.