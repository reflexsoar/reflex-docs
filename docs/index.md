# Reflex Documentation

<!-- LOGOS -->
![ReflexSOAR logo](img/color-logo-no-bg.svg#gh-light-mode-only)
![ReflexSOAR logo](img/white-logo-color-symbol-no-background.png#gh-dark-mode-only)

**ReflexSOAR** is an open-source security orchestration, automation, and incident response platform. It is designed by experts in the field to maximize SOC efficiency and orchestrate automation to abstract away mundane tasks. The outcome is a streamlined workflow, enhanced productivity, and a heightened ability to prioritize and address security incidents that truly matter.

As a team of security professionals, our primary objective in developing ReflexSOAR is to simplify Security Operations for all users. We strive to create a user-friendly and intuitive platform that empowers security teams to effectively manage and respond to security incidents. By leveraging automation, integration, and intelligent workflows, ReflexSOAR aims to streamline complex security processes, minimize manual effort, and enhance overall operational efficiency. Our goal is to provide a solution that enables security professionals of all levels to navigate the challenges of security operations with ease and confidence.

## Features
ReflexSOAR offers a comprehensive range of capabilities, including but not limited to:

* **Event Rules**: dynamically respond to Events by automatically dismissing, merging to cases, adding tags, or updating severity

* **Cases**: create Cases and leverage Case Templates to track the investigation of alerts by your analyst

* **Intel Lists**: develop internal or poll external threat Intel Lists to enrich events to further assist your analyst during their investigations

* **Inputs**: configure Inputs to pull alerts or alarms from your SIEM or other security tools for your analyst to review

* **Reflex Query Language (RQL)**: leverage mutators and expressions against alerts to granularly tailor the automated responses and actions

* **Agents**: deploy Agents within your environment to pull the alerts and alarms from your on-premise systems

* **Detections**: create your own Detection Rules to share with your Reflex subtenants

* **Playbooks****: automation and orchestration Playbooks

***This feature is still in development; however, automation is available today in the form of [Event Rules](event-rules/index.md)*

## Pricing

### *Open-Source*
ReflexSOAR is open-source under a [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). Experience the full range of features without any restrictions beyond your hardware or training capabilities. Our model is designed to offer commercial support and services, while ensuring that ReflexSOAR remains freely available to the community both now and in the future.

### *Commercial Support*
ReflexSOAR commercial support is facilitated by [H & A Security Solutions, LLC](https://www.hasecuritysolutions.com/), and is offered under the following commercial support offerings:

<div align="center">

|                                     | Open-Source     |   Standard Support           | Premium Support               |
| :---------------------------------- | :-------------: | :--------------------------: | :---------------------------: |
| **Price**                           | Zero            | Starts at $15k US            | Starts at $25k US             |
| **Professional Support**            | No              | 8 x 5                        | 8 x 5                         |
| **Number of Supported Users**       | 0               | 5 Named Users                | 5 Named Users                 |
| **Cloud Hosted**                    | No              | Included **                  | Included **                   |
| **Default Case Templates**          | No              | Included                     | Included                      |
| **Custom Case Templates**           | Not included    | Not included                 | 5 Included                    |
| **Custom Event Rule Creation**      | 0               | 25 - Implementation included | 100 - Implementation included |
| **Intel List Capacity**             | Your hardware    | 10 GB                        | 25 GB - Includes H & A lists  |
| **Organization Custom Intel Lists** | Not included    | Not included                 | Included with implementation  |

</div>

<p align="center">
***On-premises support contracts for ReflexSOAR are available at an additional cost*
</p>

## Important Topics to Visit

- [Getting Started](getting-started.md)
- [Agents](agents/index.md)
- [Cases](cases/index.md)
- [Detections](detections/index.md)
- [Events](events/index.md)
- [Event Rules](event-rules/index.md)
- [Inputs](inputs/index.md)
- [Intel Lists](intel-lists/index.md)
- [Reflex Query Language (RQL)](rql/index.md)

!!! note "ReflexSOAR or Reflex?"
    Throughout this documentation, the terms "ReflexSOAR" and "Reflex" are used interchangeably to refer to the same entity, providing a convenient and consistent way to refer to the platform.

## Versioning
ReflexSOAR adheres to a versioning convention that follows this format: `YY.MM.000-tag`.

* `YY`: two-digit year of the release
* `MM`: two-digit month of the release
* `000`: version/build number
* `tag`: additional information about the release

For instance, a version like `22.08.001` would indicate the initial release for August of 2022, while versions with tags like `RC-0` (release candidates) or `HD-01` (hotfixes) signify specific release statuses or fixes.