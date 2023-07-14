# Event Processing
**Event Processing** involves several sequential steps. In a broad sense, the retrieval and processing of Events are executed through the following procedure:

1. Agent polls an [Input](../inputs/index.md)
2. Agent pushes data to the *Bulk Event Ingest API*
3. API delivers all Events to the Event Processor service
4. Event Processor service checks each Event against [Intel Lists](../intel-lists/index.md) and [Event Rules](../event-rules/)
5. Event Processor service responds accordingly
6. Event Processor bulk inserts/updates documents in Elasticsearch for each Event
7. Events appear in the Event Queue UI

## Components
There are two major components Reflex uses to process Events:

### *Event Processor*
* The Event Processor process coordinates all Worker nodes and tells them when to start, stop and will attempt to heal workers that have crashed. 

### *Event Processor Worker*
* Event Workers are responsible for handling all Events on ingest, merging Events in to Cases, mutating events based on Event Rule hits, dismissing Events, etc.  They are a core component, if you are seeing issues with Event Ingest, there may be an issue with an Event Worker.

## Operational Modes
There are currently two operational modes 

### *Shared*
* Shared worker mode is the default state for ReflexSOAR and will be ideal for the majority of use cases.  No special configuration is needed for shared worker mode, just make sure that `REFLEX_EVENT_PROCESSOR_DEDICATED_WORKERS` is set to `false`

### *Dedicated*
* ReflexSOAR as of `2022.08.00` has the ability to run Event Workers in dedicated mode.  This will provide event workers for each organization in the system.  This mode prevents organizations from impacting eachother when they have a high volume of events or write complex Event Rules.

!!! warning
    This feature requires a Kafka node or cluster to support individual organization/tenant queues

## Configurating Dedicated Mode

!!! warning
    Max Workers per Organization is currently set on start-up.  In a future release ReflexSOAR Parent Organization Admins will be able to adjust the Max Workers for each organization on the fly via the UI (scale up or down)

To configure Dedicated Workers, follow the below steps:

1. Set the environmental variable `REFLEX_EVENT_PROCESSOR_DEDICATED_WORKERS=true`

2. Set the maximum number of workers to spin up per organization by setting `REFLEX_EVENT_PROCESSOR_MAX_WORKERS_PER_ORGANIZATION=5`, where `5` is the number of workers

3. Configure Kafka by setting `REFLEX_EVENT_PROCESSOR_KAFKA_BOOTSTRAP_SERVERS=localhost:29092`, where `localhost:29092` is the address of your Kafka bootstrap



## Environment Variables

- `REFLEX_EVENT_PROCESSOR_DISABLED` - Disables all Event Processing, nothing in Reflex will work if this is set
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_MAX_QUEUE_SIZE` - Determines how many events the Workers will spool before doing bulk inserts to the ReflexSOAR backend data store
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_WORKER_COUNT` - When in Shared mode, how many workers to spin up
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_META_DATA_REFRESH_INTERVAL` - How often workers should refresh their meta data from the ReflexSOAR backend data store.  Meta Data is Event Rules, Case Statuses, Closure Reasons, etc.
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_ES_BULK_SIZE` - How many documents the Event Workers should send at one time to the ReflexSOAR backend data store
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_LOG_LEVEL` - The logging level for the Event Processor and it's workers
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_WORKER_CHECK_INTERVAL` - How often should the Event Processor check the health of its Workers
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_DEDICATED_WORKERS` - Run Event Processing in Dedicated Mode
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_MAX_WORKERS_PER_ORGANIZATION` - When in dedicated mode, how many workers should each organization have
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_KAFKA_BOOTSTRAP_SERVERS` - Kafka server addresses
    * *Default value:* 

- `REFLEX_EVENT_PROCESSOR_KAFKA_TOPIC_RETENTION` - How long Kafka should maintain topic history
    * *Default value:* 