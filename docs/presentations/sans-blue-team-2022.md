# SANS Blue Team 2022

## Overview

The below guide is the exact steps to replicate the ReflexSOAR tour/workshop from SANS Blue Team Summit 2022.  You can follow these steps on any Linux VM by going through the [Getting Started](../getting-started.md) guide.

## Installing ReflexSOAR

For the sake of the Workshop and time see [Getting Started](../getting-started.md)

## Credentials for the Demo

```
admin:cxYh51XvmZqQF2LPm6DD8UWsc  # Opensearch Admin
admin@reflexsoar.com:HFfKGsBauuuW0LkEd238AMDMC  # ReflexSOAR Admin
```

## Setting up the VM

1. Extract the contents of reflex-sans-blue-2022.zip
2. When opening the VM if you are prompted with `I moved it` or `I copied it` select `I copied it`
3. Log in to the VM using the username `reflexsys` and password `sansblue2022`
4. Get the IP of the machine by typing `ip a`, you will need this later
5. Confirm all services are started by running `docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports }}'` it should look like below

```
NAMES                   STATUS                            PORTS
reflex-agent            Up 3 minutes
reflex-ui               Up 3 minutes (healthy)            80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp
reflex-api              Up About a minute (healthy)
memcached               Up 3 minutes (health: starting)   11211/tcp
opensearch-dashboards   Up 3 minutes                      0.0.0.0:5601->5601/tcp, :::5601->5601/tcp
opensearch              Up 3 minutes (healthy)            9300/tcp, 9600/tcp, 0.0.0.0:9200->9200/tcp, :::9200->9200/tcp, 9650/tcp
```
6. Log out of the VM

## Logging in to ReflexSOAR

!!! note Default Credentials
    When starting from the first time using the `Getting Started` process, the `install.sh` script will supply a random password for `admin@reflexsoar.com`

1. Launch your browser
2. Point your browser to https://you.rvm.ipa.ddr/
3. Log in with `admin@reflexsoar.com` and password `sansblue2022`
4. You should land on the Dashboard page
   
## Creating an Input

1. Navigate to Settings > Credentials
2. Click `New Credential`
3. Select the `Default Organization`
4. Provide a friendly name for the credential, e.g. `OpenSearch`
5. Enter the credentials to connect to OpenSearch, username `admin` and password `YCEUpbZ5hxwEHcywjUwSqUkC8`
6. Add a description to the credential e.g. `Used to connect to OpenSearch indices`
7. Save the credential
8. Navigate to Settings > Inputs
9. Click `New Input`
10. Select the `Default Organization`
11. Give the Input a friendly name e.g. `Suricata Alerts`
12. Give the Input a description e.g. `Collects Suricata Alerts from Opensearch`
13. OPTIONAL - Add tags to the input
14. Click `Next`
15. Select the `Elasticsearch` plugin

!!! note Elasticsearch/OpenSearch
    OpenSearch is supported using the Elasticsearch Input plugin

16. Select the Credential created in previous steps (`OpenSearch`)
17. Fill out the configuration with the following values

Setting | Value
--- | ---
Elasticsearch Hosts | https://opensearch:9200
Distro | opensearch
Alert Index | suricata-ids
Lucene Filter | *
HTTP Scheme | https
Auth Method | http_auth
Verify Hostname | no
TLS Verification Mode| none
Event Title Field | signature
Description Field | alert.rule
Reference Field | _id
Severity Field | severity
Original Date Field | @timestamp
Tag Fields | category, in_iface, host.hostname, proto
Signature Fields | source.ip, destination.ip, destination.port, signature, proto, rev
Search Size | 200
Search Period | 30d

18. Create the following field mappings

Field | Alias | Data Type | TLP | Tags
--- | --- | --- | --- | ---
source.ip | source_ip | ip | 3 | source_ip
destination.ip | destination_ip | ip | 3 | destination_ip
destination.port | destination_port | port | 3 | destination_port
source.port | source_port | port | 3 | source_port

19. Review the configuration
20. Click Create

## Assign an Input to an Agent

1. Navigate to Settings > Agents > Agent Groups
2. Select the edit button on DefaultAgentGroup
3. Under inputs select `Suricata Alerts`
4. Click Edit

## Working the Event Queue

1. Navigate to Events > Queue
2. Explore the Event Filter Bar
    a. Can filter by status, title, observable, date, tags, etc.
3. Explort the Event Card
    a. View details about the event using the Magnifying Glass Icon
    b. Create a case from the event using the Briefcase Icon
    c. Leave a comment on the evnet using the Comment Bubble Icon
    d. Dismiss the event using the Ear Icon (red)
    e. Create a new Event Rule using the Graph Icon (blue)

## Tagging Events with Event Rules

1. Navigate to Events > Event Rules
2. Click New Event Rule
3. Select the `Default Organization`
4. Name the rule `Tag all RFC1918 sourced events`
5. Description `Tag all events that originate from an RFC1918 IP address`
6. Rule Active to `Yes`
7. Run Rule Retroactively to `Yes`
8. Priority `1`
9. Click next, skip expiration settings
10. On the Event Query page enter the following RQL query

```python
observables exists and expand observables (
     data_type eq "ip" and (
        value incidr ["10.0.0.0/8","192.168.0.0/16","172.16.0.0/12"] and tags = "source_ip"
    ) and (
        value not incidr ["10.0.0.0/8"]
    )
)
```

11. Select `Include Events`
12. Select `Test Rule`
    a. If the rule returns 0 hits, the timeframe may need to be expanded or you have a syntax error
13. Click `Next`
14. Toggle `Add Tags`
15. Enter the tags you wish to add to the event e.g. `inside-source`
16. Click next until you hit the `Review` page
17. Click Create

### Advanced Query
Tag events that come from an RFC1918 address to a non-RF1918 address as `direction: outbound`

```python
# Make sure the event has observables
observables exists

# Expand the observables field so we can evaluate all properties on each observable
and expand observables (
     # The data type should be an ip and not be RFC1918 and be the source_ip
     data_type eq "ip"
     and value incidr ["10.0.0.0/8","192.168.0.0/16","172.16.0.0/12"]
     and tags = "source_ip"
)

# Expand the observables field again to check the destination_ip
and expand observables (
  # Should be an IP but not RFC1918 and be the destination_ip
  data_type eq "ip"
  and value not incidr ["10.0.0.0/8","192.168.0.0/16","172.16.0.0./12"]
  and tags ="destination_ip"
)
```

## Tuning the Noise with Event Rules

## Working a Case 

## Leveraging Case Templates