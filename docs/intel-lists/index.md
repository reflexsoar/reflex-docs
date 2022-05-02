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

### CSV Field Mapping
When selecting a CSV formatted file users need to provide all the field header names and the data types they map to.  Each column value will be imported in to the list as the proper data type.  A record reference number is generated to map values from the same record to eachother for cross-referencing columns.  The example below uses the Malware Bazaar Most Recent list as an example. 

#### Headers

```
date,sha256,md5,sha1,reporter,file_name,file_type,mime_type,signature,clamav,vtpercent,imphash,ssdeep,tlsh
```

#### Mapping

```
none,sha256hash,md5hash,sha1hash,none,filename,none,none,none,none,none,imphash,none,none
```