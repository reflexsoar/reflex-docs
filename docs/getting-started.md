# Getting Started
ReflexSOAR is composed of the following components:

- **Storage** - A back-end component for storing persistent data. Supported back-ends are OpenSearch or Elasticsearch
- **Memcached** - A blazing fast memory cache for use with intel data
- **Reflex API** - A web API for all requests. The core functionality of Reflex comes from the Reflex API
- **Reflex UI** - A web application for presenting a friendly user interface to analysts
- **Reflex Agent** - An agent used to get agents into ReflexSOAR
- **Optional Storage Reporting** - For additional reporting capabilities, supports OpenSearch Dashboards or Kibana

## Quickstart Installation
To streamline the initial setup process, an installation script has been developed to automate the installation of the components mentioned above. To run the installation script successfully, a machine with a minimum of 4 GB of RAM, two CPU cores, and at least 50 GB of available disk space is required. The script has undergone testing on the following operating systems to ensure compatibility and reliability:

* AlmaLinux &check; 

* Amazon Linux &check; 

* CentOS 7 &check; 

* CentOS 8 &check; 

* Ubuntu 20.04 &check; 

* Ubuntu 22.04 &check; 

### *Installation Script*
The script to install all the components for Reflex can be ran using the following command:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/reflexsoar/reflex-docs/main/quickstart/install.sh)"
```

### *Start/Stop All Components*
Upon the completion of the script, all the necessary components will be successfully installed and running. You may start and stop all components using the following commands:

```bash
cd reflexsoar # Change this to your installation folder
docker-compose stop
docker-compose start
```

### *Start/Stop/Restart Services*
You may also stop, start, and restart your individual services using commands similar to below.

```bash
docker stop reflex-api
docker start reflex-api
docker restart reflex-api
```

!!! note
    The default container names are `opensearch`, `opensearch-dashboards`, `memcached`, `reflex-api`, and `reflex-ui`. Also, all services will automatically start on a reboot or cold start of your host operating system.

### *Accessing Reflex*
You can access ReflexSOAR by connecting to your host operating system using https such as `https://localhost`. You may connect to OpenSearch Dashboards using port 5601 such as `https://localhost:5601`. OpenSearch Dashboards is only if you wish to create custom reports.

## Default Usernames and Passwords

* **Reflex**
    * username: **`admin@reflexsoar.com`**
    * password: **`reflex`**

* **OpenSearch**
    * username: **`admin`**
    * password: **`admin`**

!!! danger "Changing Default Login Information"
    We highly recommend immediately changing the default login information upon first login. The installation video [here](https://www.youtube.com/watch?v=6c1jsexKVrU) describes how to change the default login credentials.

## Uninstall Quickstart Installation
If you wish to remove the containers and data volumes created by the quickstart `install.sh` script, run the following command:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/reflexsoar/reflex-docs/main/quickstart/uninstall.sh)"
```
