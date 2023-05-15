# Inputs
Inputs control where Reflex gets Alert/Alarm data for analysts to work with.  Inputs are consumed by [Agents](../agents/index.md), which then are tasked with polling that Input for data and processing it into a format the Reflex API can understand.

## Creating Inputs
To create and configure a new input, the following steps can be used:
1. Navigate to the Inputs page
2. Click `New Input`
3. Give your Input a friendly name and provide a description
4. Select the Plugin you want to use (e.g. `Elasticsearch`)
5. Select the Credential this Input should use to connect to Elasticsearch (See [Credentials](credentials.md) if you haven't created any yet)
6. Supply the remaining configurations and field mappings
7. Select the MITRE data sources that apply
8. Confirm the input configurations
9. Click `Create`
