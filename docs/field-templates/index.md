# Field Templates
Field templates are a centralized method for informing [Inputs](../inputs/index.md) and [Detections](../detections/index.md) what to do with fields and their data from the event source. They can be used to define the field name, data type, and other settings for each relevant field in order to map a source field value to an Observable.

## Creating Field Templates
To create a new Field Template, the following steps can be used:
1. Navigate to the `Inputs` page
2. Click `Field Templates`
3. Click `New Field Template`
4. Input the necessary information in the *Overview* and *Field Settings* sections
5. Click `Create Template`

!!! note "Data Type `none`"
    When a field has it's data type set to `none` it will not be extracted as an observable on to an Event.

## For Inputs
When using a Field Template for an Input that is polled by an [Agent](../agents/index.md), the Field Template will tell the Agent to extract the values of the defined fields as Observables and place them on the Event for easier analysis.

## For Detections
Much like Field Templates for Inputs, when a Detection rule runs against source data and matches, the fields and their values from the matched data will be extracted as Observables.

Unlike Inputs however, Field Templates also define how Sigma formatted rules should convert and what field names they should use.  For example, a Sigma Rule that uses the field `Image` may conver to `process.executable` but the source data is not mapped to Elastic Common Schema and actually expects `winlog.event_data.Image`. 

!!! note "Sigma Field"
    The Sigma Field is only used when converting a Sigma rule to a Detection Rule. 