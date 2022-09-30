# SANS Blue Team 2022

## Overview

The below guide is the exact steps to replicate the ReflexSOAR tour/workshop from SANS Blue Team Summit 2022.  You can follow these steps on any Linux VM by going through the [Getting Started](../getting-started.md) guide.

## Installing ReflexSOAR

For the sake of the Workshop and time see [Getting Started](../getting-started.md)

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
5. Enter the credentials to connect to OpenSearch, username `opensearch` and password `sansblue2022`
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
Alert Index | 

## Working the Event Queue

## Tagging/Routing Events with Event Rules

## Tuning the Noise with Event Rules

## Working a Case 

## Leveraging Case Templates