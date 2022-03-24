# Reflex Query Language (RQL)

## What is it?
RQL is a query language designed to ask Reflex questions about Event.s. RQL is used when creating certain items in Reflex, such as Event Rules to query the Event data and match certain criteria.

## Supported Search Fields
The following fields are supported as part of a search.

### Event Fields

- `observables|observables.*`
  - `value`
  - `tlp`
  - `tags`
  - `spotted`
  - `safe`
  - `source_field`
  - `data_type`
  - `ioc`
  - `original_source_field`
- `title`
- `description`
- `tlp`
- `severity`
- `status`,
- `reference`
- `source`
- `signature`
- `tags`
- `raw_log|raw_log.*`

The use of **raw_log** allows accessing anything in fields within the raw log to use with RQL. Consider the below event JSON.a

```javascript

"agent": {
  "hostname": "TESTPC",
  "name": "TESTPC",
  "id": "0a27616f-4464-4bd6-b5a0-034b87dc0931",
  "type": "winlogbeat",
  "ephemeral_id": "732cabda-454a-43ea-b548-16b2bede37b5",
  "version": "7.16.1"
}
"winlog": {
  "record_id": 2515101,
  "computer_name": "TESTPC.test.int",
  "process": {
    "pid": 4,
    "thread": {
      "id": 18124
    }
  }
  "event_id": "5038",
  "task":"System Integrity"
}
```

RQL could access any field above using **raw_log**. Below are a couple examples.

```python
raw_log.winlog.event_id = "5038"
raw_log.agent.name|lowercase = 'testpc'
```

!!! Note
    In the example above **"5038"** requires double quotes around it as it is a string. Also, the use of **|lowercase** in the second example would allow matching a Windows hostname requires of it being uppercase or mixed case as some agents do not consistently enforce an all uppercase or lowercase computer name. If you had an issue where hostnames sometimes included a fully-qualified domain name (FQDN) and other times did not, you could use RQL similar to below.

```python
raw_log.winlog.comptuer_name|lowercase = 'testpc' or raw_log.winlog.comptuer_name|lowercase = "testpc.test.int"
```

Below is an example of accomplishing the same as the above RQL rule but where it is optimized to process quicker.

```python
raw_log.winlog.comptuer_name|lowercase In ['testpc','testpc.test.int']
```

This RQL processes faster because it only has one RQL step. Every time you use **and** or **or**, RQL breaks each part into a separate step. The former example would require running the **lowercase** mutator twice and an **=** value comparison twice and then process an **or** statement to try to find one or more matches.

## Supported Expressions
The following Expressions are used to compare target field data to intended data.

- `RegExp` - The item has a value that matches a regular expression e.g. `title RegExp "^Event.*"`
- `In` - The item has a value in a list of values e.g. `observables.tags.name in ["malware"]`
- `Contains` - The target value contains a specific string e.g. `description Contains "malware"`
- `ContainsCIS` - Same as `Contains` but will make the target value and checked value the same case
- `=|eq|Eq` - Equal to (strings or numbers)
- `!=|ne|Ne|NE` - Not equal to (strings or numbers)
- `>|gt` - Greater than (> or gt)
- `>=|gte` - Greater than or equal to (>= or gte)
- `<|lt` - Less than (< or lt)
- `<=|lte` - Less than or equal to (<= or lte)
- `InCIDR` - The IP address is in a specific CIDR network e.g. `192.168.1.1 InCIDR 192.168.0.0/16`
- `Is` - Use for boolean operations like "Is True" e.g. `ioc Is True`
- `Exists` - The field exists at all, useful if you don't care what the target value
- `Between` - The item has a value between a given range e.g. `tlp Between "1,3"`
- `StartsWith` - The item has a value that starts with a certain string e.g. `url StartsWith "https"`
- `EndsWith` - The item has a value that ends with a certain string e.g. `domain EndsWith ".tk"`
- `Not` - The expression within this block should not match e.g. `title Not Eq "Suspicious DNS Query"` (Can only be used on `eq`, `in`, `InCIDR`, `contains`, `between` AND `regexp`)
  - Items that don't have a specified field may match a `Not` expression e.g. `ip NOT InCIDR "192.168.0.0/16"` may match on an event not having an `ip` field, pair this with `ip exists AND ip NOT InCIDR "192.168.0.0/16"`
- `Expand` - When you want two conditions on a nested object to be true use an each statement. Example, the observable `127.0.0.1` should have a value of `127.0.0.1` and `safe` is True, query would look like `Expand observables (value = "127.0.0.1" and safe Is True)`.
- `Intel|Threat` - Allows RQL to check the value of a field against a Reflex Intel List (threat lists)

## Mutators
Mutators take a field and perform an extra operation on it to make it digestible by the down stream comparison.  Assume you want to find any Event with a domain observable where the length of the domain is longer than 20 characters

- `|length` - How long a string is e.g. `url.domain|length > 20`
- `|count` - The number of items in an array value `observables|count > 2`
- `|lowercase` - Lowercase a string (redundant for ContainsCIS but can be used for other fields)
- `|refang` - If for some reason the target value has been defanged, think `hXXps[:]//` instead of `https://` this will refang the value to perform a proper comparison e.g. `url.full|refang eq "https://www.google.com"`
- `|b64decode` - If the target value is base64 encoded and you want to write rules using the terms with in it, first base64 decode it, e.g. `command|b64decode Contains "Invoke-Mimikatz"`
- `|b64extract` - Will attempt to find base64 encoded data in a string and extract it for comparison later in the query e.g. and event contains a command `powershell -encodedCommand SW52b2tlLVdlYlJlcXVlc3QgaHR0cHM6Ly93d3cucmVmbGV4c29hci5jb20=` would extract and decode `SW52b2tlLVdlYlJlcXVlc3QgaHR0cHM6Ly93d3cucmVmbGV4c29hci5jb20=` to `Invoke-WebRequest https://www.reflexsoar.com`.  An analyst could then use a query like `command|b64extract Contains "reflexsoar.com"`
- `|urldecode` - Unescapes an escaped URL so that direct comparisons can be made
- `|any` - Force the following condition to match on any item in the array (Can only be used on `Contains` and `In` expressions)
- `|all` - Force the condition to match on all items in the array (Can only be used on `Contains` and `In` expressions)
- `|avg` - Calculates the average value given a list of values e.g. `observables.risk_score|avg > 7`
- `|max` - Finds the max value given a list of values e.g. `vulnerablities.cvss_score|max > 7`
- `|min` - Finds the minimum value given a list of values
- `|sum` - Add up all the values in a list of integer or float values
- `|split` - Splits a string that contains spaces in to an array
- `|geo_country` - Returns the ISO Code for the country an IP resides in
- `|geo_continent` - Returns the ISO Code for the contient an IP resides in
- `|geo_timezone` - Returns the timezone an IP resides in
- `|reverse_lookup` - Takes an IP and attempts to return the associated host name
- `|nslookup_a` - Fetches the A record for a domain name
- `|nslookup_aaaa` - Fetches the AAAA record for a domain name
- `|nslookup_mx` - Fetches the MX records for a domain name
- `|nslookup_ns` - Fetches the NS records for a domain name
- `|nslookup_ptr`- Fetches the PTR records for a domain
- `|is_private` - Returns True if an IP is RFC1918
- `|is_global` - Returns True if an IP is routable on the internet
- `|is_multicast` - Returns True if an IP is multicast
- `|is_ipv6` - Returns True if an IP is IPv6

## Future Additions

- Support for IP ranges not using CIDR example `ip between "192.168.0.1-10"`
- `|semver` - Semantic Versioning, will convert a string to a tuple so it can be compared e.g. `process.version|semver < 3.1.0` so you can exclude events from a process with a known bug in it
- Comparisons for dates (`between`,`=`,`before (<)`,`after (>)`) e.g. `whois.last_updated before "2021-11-08 00:00:00"` or `whois.last_updated after "7d"` or `whois.registration_date after "14d`
- `Now` term to calculate the current date for previous date comparisons e.g. `event.created_at before Now`


## Example Queries

```python
# Match any Supicious DNS query only if it came from the Administrator on a domain joined machine and the target observable is evil.com
title = "Suspicious DNS Query" and user Contains "Administrator" and hostname EndsWith "ad.reflexsoar.com" and (observables.data_type = "domain" and observables.value = "evil.com")
```

```python
# Match any cases referencing malware or with a severity higher than 3
description Contains "malware" or severity > 3
```

```python
# Match any event that has a domain with evil.com or and IP with 127.0.0.1
(observables.data_type = "domain" and observables.value = "evil.com") or (observables.data_type = "ip" and observables.value = "127.0.0.1")
```

```python
# Match any Event that has all of the below observables
observables.values|all in ["evil.com","reflexsoar.com"]
```

```python
# Match any event that contains a base64 encoded command that once decoded contains the following phrases
command exists and command|b64decode|lowercase Contains ["invoke-mimikatz","invoke-bloodhound","invoke-powerdump","invoke-kerberoast"]
```

```python
# Match any suspicious DNS query for a specific domain that originates from a specific user and source process 
# Should always be this event title
title = "Suspicious DNS Query"

# Observables should always exist
and observables exists

# Brian must be the source user of the event
and expand observables (value Contains "Brian" and source_field|lowercase = "winlog.event_data.user")

# And the DNS resolution should always be for netwars-support.slack.com
and expand observables (value = "netwars-support.slack.com" and source_field|lowercase = "dns.question.name")

# And should originate from Slack
and raw_log.process.executable EndsWith "slack.exe"
```

```python
# Check to see if the user in the event is in the Allowed Users intel list
expand observables ( data_type = "user" and intel(value|uppercase, 'Allowed Users'))
```
