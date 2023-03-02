# Field Templates Overview

Field templates are a centralized method for informing [Inputs](../inputs/index.md) and [Detections](../detections/index.md) what to do with fields and their data from the event source.

!!! note Observable extraction for `none`
    When a field has it's data type set to `none` it will not be extracted as an observable on to an Event.

## For Inputs

When using a Field Template for an Input that is polled by an Agent, the Field Template will tell the Agent to extract the values of the defined fields as observables and place them on the Event.

## For Detections

Much like Field Templates for Inputs, when a Detection rule runs against source data and matches, the fields and their values from the matched data will be extracted as observables.

Unlike Inputs however, Field Templates also define how Sigma formatted rules should convert and what field names they should use.  For example, a Sigma Rule that uses the field `Image` may conver to `process.executable` but the source data is not mapped to Elastic Common Schema and actually expects `winlog.event_data.Image`.