# Reflex Documentation
!!! note
    ReflexSOAR goes live on May 2nd, 2022. We advise against installing it until then unless you are using one of our commercially supported offerings.

!!! warning
    This documentation site will not be complete until the go-live date of May 2nd, 2022.

## What is it?
ReflexSOAR is an open-source event triage, investigation, and automation platform. It is designed by experts in the field to maximize SOC efficiency and orchestrate automation to abstract away mundane tasks. The result is streamlined efficiency and focus on alerts or events that matter. ReflexSOAR provides the following capabilities:

- **Event Rules** - Dynamically respond to events by automatically dismissing, merging to cases, adding tags, or updating severity.
- **Cases** - Create cases and leverage case templates to track the investigation of alerts by your analyst.
- **Intel Lists** - Develop internal or poll external threat intel lists to enrich events to further assist your analyst during their investigations.
- **Inputs** - Configure inputs to pull alerts or alarms from your SIEM or other security tools for your analyst to review.
- **Reflex Query Language** - Leverage mutators and expressions against alerts to granularly tailor the automated responses and actions.
- **Agents** - Deploy agents within your environment to pull the alerts and alarms from your onpremise systems.

ReflexSOAR is composed of the following components:

- **Storage** - A back-end component for storing persistent data. Supported back-ends are OpenSearch or Elasticsearch
- **Memcached** - A blazing fast memory cache for use with intel data
- **Reflex API** - A web API for all requests. The core functionality of Reflex comes from Reflex API
- **Reflex UI** - A web application for presenting a friendly user interface to analysts
- **Optional Storage Reporting** - For additional reporting capabilities, supports OpenSearch Dashboards or Kibana

## Pricing
### Open-Source
ReflexSOAR is an open-source under a GNU General Public License v3.0. Enjoy all features with zero limitations outside your own hardware or training. Our model is to provide commercial support and services but provide ReflexSOAR free to the community now and always.

### Commercial Support
ReflexSOAR commercial support is facilitated by H & A Security Solutions LLC and is offered under the following commercial support offerings.

|                                     | Open-Source     |   Standard Support           | Premium Support               |
| :---------------------------------- | :-------------: | :--------------------------: | :---------------------------: |
| **Price**                           | Zero            | Starts at $15k US            | Starts at $25k US             |
| **Professional Support**            | No              | 8 x 5                        | 8 x 5                         |
| **Number of supported users**       | 0               | 5 Named Users                | 5 Named Users                 |
| **Cloud Hosted**                    | No              | Included **                  | Included **                   |
| **Default Case Templates**          | No              | Included                     | Included                      |
| **Custom Case Templates**           | Not included    | Not included                 | 5 Included                    |
| **Custom Event Rule Creation**      | 0               | 25 - Implementation included | 100 - Implementation included |
| **Intel list capacity**             | You hardware    | 10 GB                        | 25 GB - Includes H & A lists  |
| **Organization custom intel lists** | Not included    | Not included                 | Included with implementation  |

** On-premises support contracts for ReflexSOAR are available at an additional cost

## Topics

- [Getting Started](getting-started.md)
- [Agents](agents/index.md)
- [Credentials](credentials/index.md)
- [Inputs](inputs/index.md)
- [Events](events/index.md)
- [Reflex Query Language (RQL)](rql/index.md)
- [Backup & Restore](backup-and-restore.md)

## Versioning

Reflex follows the following version convention

- YY.MM.000-tag

Broken down this `22.05.001` would be the first release for August 2022.  Tags can be things like `RC-0` for release candidates or `HF-01` for hotfixes
