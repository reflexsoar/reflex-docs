# Overview

## What are Inputs
Inputs control where Reflex gets Alert/Alarm data for analysts to work on.  Inputs are consumed by Agents, which then are tasked with polling that Input for data and processing the data into a format that the Reflex API understands.

## Configuring an Input

1. Navigate to the Inputs page
2. Select `New Input`
3. Give your input a friendly name
4. Select the Plugin you want to use e.g. `Elasticsearch`
5. Select the Credential this input should use to connect to Elasticsearch (See [Credentials](credentials.md) if you haven't created any yet.)
6. Supply a configuration and a field mapping
7. Tag the Input with tags to help you understand what it's for
8. Save
