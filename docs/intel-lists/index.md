# Intel Lists
**Intel Lists** are used by Reflex to supply operational or threat intelligence to the Reflex system. These lists can contain various types of information such as malicious IP addresses, blacklisted domain names, approved user identities, and more. Intel Lists can be referenced in [RQL (Reflex Query Language)](../rql/index.md) or utilized within the Event ingest pipeline to automatically tag Events based on the intelligence provided.

## Creating and Intel List
To create a new Intel List, the following steps can be used:

1. Navigate to the Intel List Manager page
2. Click `New List`
3. Provide your list details
4. Enable external polling if needed
5. Enter the values of your Intel List
6. Select any relevant flags to set as Observables
7. Click `Create` after reviewing the list details

!!! note "Intel Explorer"
    Intel Explorer is where you can go to view *all* Intel List values, including those brought in by external sources. 

## Intel List Types
There are currently three supported types of Intel Lists available in Reflex:

* **Values**: contains particular values (e.g., specific usernames)
* **Patterns**: contains recognizable patterns
* **CSV**: used for CSV formatted fields

## Configuring an Intel List
There are several parts to configuring Intel Lists.

### *List Details*

* **Organization**: select which Organization the Intel List pertains to
* **Name**: give the Intel List a relevant name
* **List Type**: select the List type
* **Data Type**: select the data type for the Intel List values (e.g., `user` for usernames)
* **Tag Observables on list match?**: option to add the name of the List to each Observable on an Event that matched the list

!!! note "Example of Tagged Observables"
    A List named `Admin Users` would add a tag formatted using a snake case to an Event as `list:admin_users`.

* **List Active**: defines if the list is active or disabled

### *External Feed*

* **Enable External Polling?**: option to enable external polling, which allows Reflex to fetch intelligence from external sources

!!! info "Enabling External Polling"
    When `Enable External Polling` is set to `YES`, the values in the List will be automatically polled and can NOT be manually edited. The [Threat Poller Service](../services/threat-poller.md) will periodically fetch the data from the remote URL.

* **URL**: provide the URL of the external source to poll values from
* **Polling Interval**: define how often new data should be polled from the external source in minutes

### *Values*

* Provide the values for your Intel List, separating them by new lines

### *Flags*

* **IOC**: sets an `IOC` flag on the Observable of the Event when a value in the List is matched, meaning the value is an indicator of compromise
* **Safe**: sets a `safe` flag on the Observable of the Event when a value in the List is matched, meaning the value is safe
* **Spotted**: sets a `spotted` flag on the Observable of the Event when a value in the List is matched, meaning the value has been spotted/seen

### *Review*

* After reviewing your Intel List for accuracy, click `Create`.


<!--
- **To Memcached**: Items on the Intel List will be pushed to the configured memcached instance.  The intel items can be accessed using memcached namespaces in the format of `{list_name}:{data_type}:{value}`.  Lists are represented in snake case where a list named `Bad Domain Names` would become `bad_domain_names`.  The environmental variables for Memcached can be found here [Threat Poller Memcached Config](../system/environment-variables#threat-poller-memcached-config)
-->

## CSV Field Mapping
When selecting a CSV formatted file, users need to provide all the field header names and the data types they map to.  Each column value will be imported in to the list as the proper data type.  A record reference number is generated to map values from the same record to eachother for cross-referencing columns.  The example below uses the [Malware Bazaar Most Recent list](https://bazaar.abuse.ch/) as an example. 

### *Headers*

```
date,sha256,md5,sha1,reporter,file_name,file_type,mime_type,signature,clamav,vtpercent,imphash,ssdeep,tlsh
```

### *Mapping*

```
none,sha256hash,md5hash,sha1hash,none,filename,none,none,none,none,none,imphash,none,none
```

