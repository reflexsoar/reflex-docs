# Rule Types
There are currently four available options for detection rules in Reflex: **Match**, **Threshold**, **Field Comparison**, and **New Terms**. Each rule type requires a valid base query to utilize if their own ways.

This page will describe these detection rule types in depth as well as provide examples for usage.

## Match
This rule type is the simplest such that it alerts on events where a particular field (or fields) matches a particular value (or doesn't match). 

### Example
* Alert on every detection a user successfully logs in remotely
    ```
    Base Query: (event.code:4624 AND winlog.event_data.LogonType:10)
    ```

## Threshold
Threshold detections will only alert when the number of detections exceeds or is below a specified threshold. 
* *Group By*: specify a specific value to apply the threshold to the detection
* *Operator*: define how the threshold is met
* *Threshold*: the number of items required for the detection to fire
* *Alarm per Field Value*: threshold will apply to single distinct values
* *Dynamic Threshold*: will determine a threshold automatically based on a baseline
* *Max Events*: how many events to return when the threshold is met


### Example
* Alert when specific users successfully log in more than ten times in a set period.
    ```
    Base Query: (event.code: 4624)
    Group By: user.name
    Operator: >=
    Threshold: 10 
    Alarm per Field Value: YES
    Max Events: 10
    ```

## Field Comparison
Field Comparison detection types are similar to Match detections, but with more flexibility.
* *Source Field*: the source field to compare against the target
* *Operator*: how to compare the fields
* *Target Field*: the target field to compare against the source

### Example
* Description
    ```
    Base Query: 
    Source Field:
    Operator:
    Target Field:
    ```

## New Terms
New Terms detection types will look for new field values based on a predetermined baseline. 

### Example
* Alert when a user with a new username successfully logs in to the system.
```

```

