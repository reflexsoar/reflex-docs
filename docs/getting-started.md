# Getting Started

ReflexSOAR is composed of the following components:

- **Storage** - A back-end component for storing persistent data. Supported back-ends are OpenSearch or Elasticsearch
- **Memcached** - A blazing fast memory cache for use with intel data
- **Reflex API** - A web API for all requests. The core functionality of Reflex comes from the Reflex API
- **Reflex UI** - A web application for presenting a friendly user interface to analysts
- **Reflex Agent** - An agent used to get agents into ReflexSOAR
- **Optional Storage Reporting** - For additional reporting capabilities, supports OpenSearch Dashboards or Kibana

## Quickstart Installation

To simplify getting started, a installation script has been created that will automatically install of the components listed above. The installation script requires a machine with at least 4 GB of RAM, two CPU cores, and 50 GB of free disk space. The script has been tested on the below operating systems.

- AlmaLinux
- Amazon Linux
- CentOS 7
- CentOS 8
- Ubuntu 20.04
- Ubuntu 22.04

The script to install all the components can be ran using the command below:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/reflexsoar/reflex-docs/main/quickstart/install.sh)"
```

Once the script completes you now have all the components running. You may start and stop all components using the following commands:

```bash
cd reflexsoar # Change this to your installation folder
docker-compose stop
docker-compose start
```

You may also start, stop, and restart your individual services using commands similar to below.

```bash
docker stop reflex-api
docker start reflex-api
docker restart reflex-api
```

Please note, the default container names are opensearch, opensearch-dashboards, memcached, reflex-api, and reflex-ui. Also, all services will automatically start on a reboot or cold start of your host operating system.

You can access ReflexSOAR by connecting to your host operating system using https such as https://localhost. You may connect to OpenSearch Dashboards using port 5601 such as https://localhost:5601. OpenSearch Dashboards is only if you want to create custom reports.

The default username and password for ReflexSOAR is **admin@reflexsoar.com** with a password of **reflex**. The default username and password for OpenSearch is **admin** with a password of **admin**. We highly recommend changing these. The installation video walks through how to change these passwords.

### Uninstall Quickstart Installation

If you wish to remove the containers and data volumes created by the quickstart install.sh script, run this command below.

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/reflexsoar/reflex-docs/main/quickstart/uninstall.sh)"
```

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