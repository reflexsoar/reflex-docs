# Elasticsearch
According to [Elasticsearch](https://www.elastic.co/what-is/elasticsearch):

> Elasticsearch is a distributed, free and open search and analytics engine for all types of data, including textual, numerical, geospatial, structured, and unstructured.

## Elasticsearch Configuration
When configuring your Input, this section of configuration will tell Reflex how to interact with Elasticsearch.

* **Elasticsearch Hosts**: address of the Elasticsearch host (e.g., `https://localhost:9200`)
* **Distro**: which distro (distributed version) of Elasticsearch to use
* **Alert Index**: target index where Reflex should look for Events
* **Lucene Filter**: can be used to limit further what Events are pulled into Reflex
* **HTTP Scheme**: choice to connect to Elasticsearch over HTTP or HTTPS
* **Auth Method**: authentication via an Elastic API key or basic authentication
* **CA Cert Path**: path to your clusters certificate authority (CA) public certificate
* **Verify Hostname**: option to verify the hostname
* **TLS Verification Mode**: the mode TLS will use for verification
