# Rule Types
There are currently four available options for detection rules in Reflex: **Match**, **Threshold**, **Field Comparison**, and **New Terms**. Each rule type requires a valid base query to utilize if their own ways.

This page will describe these detection rule types in depth as well as provide examples for usage.

---

## Match
This rule type is the simplest such that it alerts on events where a particular field (or fields) matches a particular value (or doesn't match). 

* Only a valid base query is needed for this detection type

### Example

```
# Alert on every detection a user successfully logs in remotely

Base Query: (event.code:4624 AND winlog.event_data.LogonType:10)
```

---

## Threshold
Threshold detections will only alert when the number of detections exceeds or is below a specified threshold. 

* *Group By*: specify a specific value to apply the threshold to the detection
* *Operator*: define how the threshold is met
* *Threshold*: the number of items required for the detection to fire
* *Alarm per Field Value*: threshold will apply to single distinct values
* *Dynamic Threshold*: will determine a threshold automatically based on a baseline
* *Max Events*: how many events to return when the threshold is met


### Example

```
# Alert when specific users successfully log in more than ten times in a set period

Base Query: (event.code: 4624)
Group By: (winlog.user.name)
Operator: >=
Threshold: 10 
Alarm per Field Value: YES
Max Events: 10
```
---

## Field Comparison
Field Comparison detection types are similar to Match detections, but provide more flexibility by allowing you to specify *how* fields should or shouldn't match.

* *Source Field*: the source field to compare against the target
* *Operator*: how to compare the fields (equal, not equal, more than, less than, etc.)
* *Target Field*: the target field to compare against the source

### Example

```
# Alert when a process name doesn't match the original file name

Base Query: (event.code: 4688)
Source Field: (winlog.event_data.ProcessName)
Operator: !=
Target Field: (winlog.event_data.OriginalFileName)
```

---

## New Terms
New Terms detection types will look for new field values based on a predetermined baseline. 

### Example
```
# Alert when a scheduled task is created with a name that has not been previously observed in the environment during a specific time period

Base Query: (event.code: 4698 AND _exists_:"winlog.event_data.TaskName")
Terms Field: winlog.event_data.TaskName
Windows Size: 30
Max Terms: 2000
```

---

## Indicator Match 
Indicator Match detection types are triggered when a base query matches field value information provided in an Intel List. 

### Example

```
# Alert on successful logins by users in a `Domain Admins` Intel List

Base Query: (event.code: 4624)
Indicator Field: user.name
Intel List: Domain Admins
```
