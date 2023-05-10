# Rule Types
There are currently four available options for detection rules in Reflex: **Match**, **Threshold**, **Field Comparison**, and **New Terms**. Each rule type requires a valid base query to utilize if their own ways.

This page will describe these detection rule types in depth as well as provide examples for usage.

## Match
This rule type is the simplest such that it alerts on events where a particular field (or fields) matches a particular value (or doesn't match).  

```
# This rule will alert when a user successfully logs in remotely

event.code:4624 AND winlog.event_data.LogonType:10
```

## Threshold
Description
```
Example
```

## Field Comparison
Description
```
Example
```

## New Terms
Description
```
Example
```

