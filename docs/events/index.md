# Overview

## What are Events?
Events in ReflexSOAR are anything you want to act on in the Event Queue; they do not have to be security related, they could be Orion/WhatsUpGold alerts.  Events are the primary action item for Analysts and Users of ReflexSOAR and will appear on the Event Queue as a card.

## Event Signatures

Event Signatures are the mechanism that ReflexSOAR uses to "roll up" or "deduplicate" similar events.  By default when using the ReflexSOAR agent, the agent will compute the signature for the Event.  If using the API directly without an agent, you will need to supply the signature logic yourself.  Event Signatures use the following psuedo logic for computation:

```
md5(str(event_title, ...signature_fields))
```

!!! note "No signature provided"
    If no signature is provided the API will use the following logic to compute a signature
    ```
    md5(event_title+iso8601_date_string)
    ```

## Event States

- **New** - The default state of all new events, unless acted on by an Event Rule that overrides this status
- **Open** - The state an event goes to when added to a case
- **Dismissed** - The state an event goes to when it has been automatically or manually dismissed.
- **Closed** - The Event has been worked in a case and has subsequently been closed

## Event Processing
Event Processing is handled through multiple steps.  At a high level Events are retreived and processed in the following fashion:

1. A ReflexSOAR agent polls an input
2. The ReflexSAOR agent pushes to the Bulk Event Ingest API
3. The API hands all events off the the Event Processor service
4. The Event Processor service checks each incoming event against Intel and Event Rules
5. The Event Processor performs all indicated actions per Intel and Event Rules
6. The Event Processor bulk inserts/updates documents in Elasticsearch/Opensearch for each event
7. The Events show up in the Event Queue in the UI