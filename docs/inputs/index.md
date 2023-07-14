# Inputs
**Inputs** control where Reflex gets Alert/Alarm data for analysts to work with.  Inputs are consumed by [Agents](../agents/index.md), which then are tasked with polling that Input for data and processing it into a format the Reflex API can understand.

!!! info "Current Plugin Support"
    At this time, Reflex *only* supports the [Elasticsearch](elasticsearch.md) plugin.

## Creating Inputs
To create a new input, the following steps can be used:

1. Navigate to the Inputs page
2. Click `New Input`
3. Give your Input a friendly name and provide a description
4. Select the Plugin you want to use (e.g. `Elasticsearch`)
5. Select the Credential this Input should use to connect to Elasticsearch (See [Credentials](credentials.md) if you haven't created any yet)
6. Supply the remaining configurations and field mappings
7. Select the MITRE data sources that apply
8. Confirm the input configurations
9. Click `Create`

## Plugin Configuration
In order for the Input plugin to properly work, specific configuration must be done.

### *Elasticsearch Configuration*
See [Elasticsearch](elasticsearch.md)

### *Event Base Configuration*
This section of configuration determines what data is included on an [Event](../events/index.md) shipped by an [Agent](../agents/index.md).

* **Event Title Field**: title of the Events as they will appear in the Event Queue
* **Description Field**: description to be extracted for the Event
* **Reference Field**: defines a field that will provide a unique value each Event
* **Severity Field**: field that determines the severity of the Event on a scale of 1-4
* **Original Date Field**: preserves the original time the alert was generated
* **Tag Fields**: fields to derive tags from that will appear on the side of an Event card
* **Signature Fields**: a field or combination of fields used to compute an [Event's signature](../events/index.md) 
* **Search Size**: define the number of Events to return each poll
* **Search Period**: determines how far back in time to go in the source index
* **Static Tags**: tags that will always be applied to these Events

## Additional Configuration

### *Field Mappings*
Field mappings control how source data is mapped to a data type in Reflex. These mappings extract data that will appear in the form of Observables on Event cards. For example, mapping an IP address to the `IP` data type will allow you to conduct CIDR notation checks using RQL.

### *MITRE Configuration***
 Data sources allow you to define what specific data sources (logs) will be provided for this input when aligned with the MITRE ATT&CK framework of attack techniques and tactics. By utilizing these data sources, [Detections](../detections/index.md) can automatically recommend other Detections that require specific data sources.

 ***This feature is still in the beta phase*