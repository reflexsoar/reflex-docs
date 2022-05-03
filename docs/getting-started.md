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
