# Reflex Query Language (RQL)

## What is it?
RQL is a query language designed to ask Reflex questions about Event.s. RQL is used when creating certain items in Reflex, such as Event Rules to query the Event data and match certain criteria.

## Supported Expressions
The following Expressions are used to compare target field data to intended data.

- `RegExp` - The item has a value that matches a regular expression e.g. `title RegExp "^Event.*"`
- `In` - The item has a value in a list of values (e.g. tags In ['foo','bar']) e.g. `observables.tags.name in ["malware"]`
- `Contains` - The target value contains a specific string e.g. `description Contains "malware"`
- `ConaintsCIS` - Same as `Contains` but will make the target value and checked value the same case
- `=|eq|Eq` - Equal to (= or eq)
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

## Mutators
Mutators take a field and perform an extra operation on it to make it digestible by the down stream comparison.  Assume you want to find any Event with a domain observable where the length of the domain is longer than 20 characters

- `|length` - How long a string is e.g. `url.domain|length > 20`
- `|count` - The number of items in an array value `observables|count > 2`
- `|lowercase` - Lowercase a string (redundant for ContainsCIS but can be used for other fields)
- `|refang` - If for some reason the target value has been defanged, think `hXXps[:]//` instead of `https://` this will refang the value to perform a proper comparison e.g. `url.full|refang eq "https://www.google.com"`
- `|b64decode` - If the target value is base64 encoded and you want to write rules using the terms with in it, first base64 decode it, e.g. `command|b64decode Contains "Invoke-Mimikatz"`
- `|urldecode` - Unescapes an escaped URL so that direct comparisons can be made
  - `|any` - Force the following condition to match on any item in the array (Can only be used on `Contains` and `In` expressions)
- `|all` - Force the condition to match on all items in the array (Can only be used on `Contains` and `In` expressions)

## Future Additions

- Support for IP ranges not using CIDR example `ip between "192.168.0.1-10"`
- `|semver` - Semantic Versioning, will convert a string to a tuple so it can be compared e.g. `process.version|semver < 3.1.0` so you can exclude events from a process with a known bug in it


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