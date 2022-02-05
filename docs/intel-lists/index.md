# Overview

Intel Lists are used by Reflex to provide operational or threat intelligence to the Reflex system.  This intel can come in the form of bad IP addresses, banned domain names, approved users, etc.  Intel lists can be reference in RQL or can be used to tag Events automatically as part of the Event ingest pipeline.

## Configuring an Intel List

### External Sources 

Threat lists can pull information from external URLs configured to do so.  By adding a URL to the `URL` field and setting the `Polling Interval`, the Threat Poller Service will periodically fetch the data at the remote URL.

!!! Note
    Enabling external polling will prevent manual editing of the threat list

### Intel List Actions

- **Tag Observables on list match**: If enabled, this setting will add the name of the list to each observable on an Event that matched the list.  The list named will be formatted using snake case where a list named `Bad Domain Names` would add a tag like `list: bad_domain_names`
- **To Memcached**: Items on the Intel List will be pushed to the configured memcached instance.  The intel items can be accessed using memcached namespaces in the format of `{list_name}:{data_type}:{value}`.  Lists are represented in snake case where a list named `Bad Domain Names` would become `bad_domain_names`.  The environmental variables for Memcached can be found here [Threat Poller Memcached Config](../system/environment-variables#threat-poller-memcached-config)