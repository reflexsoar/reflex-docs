# Getting Started

## Docker

### Docker Compose

1. Create a compose file with the following service declarations

```
services:

  reflex-api:
    environment:
      - REFLEX_ES_URL=es01:9200
      - REFLEX_ES_USERNAME=myelasticuser
      - REFLEX_ES_PASSWORD=supersecretpasswordthatihopeyouchanged
      - REFLEX_ES_CA=/ca.crt
      - REFLEX_ES_CERT_VERIFY=true
      - REFLEX_DISABLE_THREAT_POLLER=true
      - REFLEX_ES_DISTRO=opensearch
    image: hasecuritysolutions/reflex-api:latest
    container_name: reflex-api
    volumes:
      - ../reflex-api/instance/application.conf:/instance/application.conf
      - ../reflex-api/ca.crt:/ca.crt

  reflex-ui:
    image: hasecuritysolutions/reflex-ui:latest
    container_name: reflex-ui
    ports:
      - 80:80
      - 443:443
```

2. Create a new file called `application.conf`
3. Add the following entries and change the values
  ```
  MASTER_PASSWORD = "somethingdifferentthanthesecretkey"
  SECRET_KEY = "pleasechangemetosomethingdifferent"
  SECURITY_PASSWORD_SALT = "something_super_secret_change_in_production"
  ```
4. Change `REFLEX_ES_URL` to the hostnames of your Elasticsearch cluster
5. Change `REFLEX_ES_USERNAME` and `REFLEX_ES_PASSWORD`
6. Optional, supply a CA cert if connecting to Elasticsearch over TLS
7. Optional, set `REFLEX_ES_CERT_VERIFY=true` to make sure certs are valid
8. Bring the containers up
9. Run `docker exec reflex-api sh -c "pipenv run python setup.py"` to perform initial setup
10. Navigate to https://localhost
11. Login as admin\reflex

## Optional Environment Variables

- `REFLEX_PLUGINS_DIR` - Where on the server side Reflex should store plugin zip files
- `REFLEX_CASE_FILES_DIR` - Where on the server side Reflex should uploaded case files
- `REFLEX_MAX_UPLOAD_SIZE` - How large of a file upload to support
- `REFLEX_OBSERVABLE_FILES_DIR` - If a file is sent in as an observable where should Reflex store those files
- `REFLEX_OBSERVABLE_FILES_PASSWORD` - The password for accessing observable file upload zip files (default: `infected`)
- `REFLEX_ES_URL` - The URL to your Elasticsearch or Opensearch hosts `localhost:9200`
- `REFLEX_ES_AUTH_SCHEMA` - What authentication scheme to use when connecting to Elasticsearch or Opensearch `api|http`
- `REFLEX_ES_USERNAME` - The username or API key use to connect to Elasticsearch or Opensearch
- `REFLEX_ES_PASSWORD` - The password or API key use to connect to Elasticsearch or Opensearch
- `REFLEX_ES_SCHEME` - What HTTP scheme to use when connecting to Elasticsearch or Opensearch `http|https`
- `REFLEX_ES_CA` - A custom supplied Certificate Authority cert for when Elasticsearch or Opensearch are using custom HTTP certs
- `REFLEX_ES_CERT_VERIFY` - Whether Reflex should verify HTTP certificates when trying to connect o Elasticsearch or Opensearch
- `REFLEX_ES_SHOW_SSL_WARN` - Hide warnings about ignoring certification verification
- `REFLEX_ES_DISTRO` - Tells Reflex if you are using Elasticsearch or Opensearch as the backend
- `REFLEX_THREAT_LIST_POLLER_INTERVAL` - How often, in seconds, the threat list poller should look to URLs for new data, default `3600`
- `REFLEX_DISABLE_THREAT_POLLER` - Turn off the Threat List polling service, default `False`
- `REFLEX_THREAT_POLLER_LOG_LEVEL` - Change the Threat poller logging level, default `ERROR`
- `REFLEX_HOUSEKEEPER_DISABLED` - Turn off the Housekeeper service, default `False`
- `REFLEX_HOUSEKEEPER_LOG_LEVEL` - Change the Housekeeper logging level, default `ERROR`
- `REFLEX_AGENT_PRUNE_INTERVAL` - How often, in seconds, Reflex should delete agents that have not checked in to the system, default `900`
- `REFLEX_EVENT_PROCESSING_THREADS` - Scales up the Event ingest pipeline to better support bulk event insertion, default `5`
- `REFLEX_DISABLE_SCHEDULER` - Disables all background jobs including Threat Poller, House Keeper, Notifications, Playbook Brokering, SLA Monitoring, default `False`
- `REFLEX_LOG_LEVEL` - The overall log level for Reflex, default `ERROR`