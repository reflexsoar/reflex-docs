# Environment Variables

- REFLEX_PLUGINS_DIR
- REFLEX_CASE_FILES_DIR
- REFLEX_MAX_UPLOAD_SIZE
- REFLEX_OBSERVABLE_FILES_DIR
- REFLEX_OBSERVABLE_FILES_PASSWORD

## Backend Elasticsearch/Opensearch

- REFLEX_ES_URL
- REFLEX_ES_AUTH_SCHEMA
- REFLEX_ES_USE_SSL
- REFLEX_ES_CA
- REFLEX_ES_CERT_VERIFY
- REFLEX_ES_SHOW_SSL_WARN
- REFLEX_ES_DISTRO

## Threat Poller Configuration

More information can be found on Threat Poller [here](../services/threat-poller.md)

- REFLEX_THREAT_LIST_POLLER_INTERVAL
- REFLEX_DISABLE_THREAT_POLLER
- REFLEX_THREAT_POLLER_LOG_LEVEL

### Threat Poller Memcached Config

- REFLEX_THREAT_POLLER_MEMCACHED_HOST
- REFLEX_THREAT_POLLER_MEMCACHED_PORT
- REFLEX_THREAT_POLLER_MEMCACHED_TTL

## SLA Monitor Service

More information can be found on SLA Monitor [here](../services/sla-monitor.md)

- REFLEX_SLAMONITOR_INTERVAL
- REFLEX_DISABLE_SLAMONITOR
- REFLEX_SLAMONITOR_LOG_LEVEL

## Scheduled Services

More information can be found on services [here](../services/overview.md)

- REFLEX_DISABLE_SCHEDULER

## Housekeeper Service

- REFLEX_HOUSEKEEPER_DISABLED
- REFLEX_HOUSEKEEPER_LOG_LEVEL
- **REFLEX_AGENT_PRUNE_INTERVAL**: How often Housekeeper should run the agent pruning job
- **REFLEX_AGENT_PRUNE_LIFETIME**: Tells Housekeeper how long an agent should be offline in `days` before Housekeeper should delete it from the system.

## Event Processing
- REFLEX_EVENT_PROCESSING_THREADS

## Debug
- REFLEX_LOG_LEVEL
