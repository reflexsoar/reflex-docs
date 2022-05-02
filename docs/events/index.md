# Overview

## What are Events?
Events in ReflexSOAR are anything you want to act on in the Event Queue; they do not have to be security related, they could be Orion/WhatsUpGold alerts.  Events are the primary action item for Analysts and Users of ReflexSOAR and will appear on the Event Queue as a card.

## Event Signatures

Event Signatures are the mechanism that ReflexSOAR uses to "roll up" or "deduplicate" similar events.  By default when using the ReflexSOAR agent, the agent will compute the signature for the Event.  If using the API directly without an agent, you will need to supply the signature logic yourself.  Event Signatures use the following psuedo logic for computation:

```
md5(str(event_title, ...signature_fields))
```

!!! note
    If no signature is provided the API will use the following logic to compute a signature
    ```
    md5(event_title+iso8601_date_string)
    ```

## Event States

- **New**
- **Open**
- **Dismissed**

## Event Processing
