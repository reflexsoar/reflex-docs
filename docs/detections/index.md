# Detections
Detections, or _detection rules_, are a collection of queries that look for particular behaviors in log sources/Inputs. Detections cannot be configured until a Input is created (see [Inputs](../inputs/index.md) for detailed information on how to configure these).

## Creating Detections
To create new detection rules, the followings steps can be used:
1. Navigate to the `Detections` page
2. Click `New Detection`
3. Click `Next` after filling out the necessary information for each section
4. Once all settings have been configured, review the resulting query
5. Click `Create`

## Configuring Detections
There are several pieces of information required to create successful detection rules. The following italicized headers provide a detailed description of each section in the detection rule creation process.

### _Details_
   * **Import from Sigma?**: allows you to paste in previous Sigma queries and convert them to Reflex
   * **Organization**: the organization to apply the rule to
   * **Name**: a relevant name to describe the detection
   * **Description**: a brief description of what the detection does (optional)
   * **Input**: what input the detection rule will use
   * **Tags**: relevant tags to apply to events triggered by the rule

!!! note "Always Document"
   Don't avoid this section. Do yourself a favor and document in detail the purpose of this detection so you don't forget it.

### _Configuration_
* **Rule Status**: the state the rule is in for easier identification
* **[Rule Type](rule-types.md)**: the type of detection rule
* **Severity**: determines the severity of the events the rule with detect

!!! note "Severity"
   Changing the severity will automatically update the risk score; however, it can still be manually changed.

### _Schedule_
* **Run Interval**: how often the detection will run in minutes

!!! note "Run Interval"
   The Run Interval will automatically adjust itself and the Lookbehind time if the detection is ran late under any circumstance.

* **Lookbehind**: how far back the detection should look in minutes

!!! note "Lookbehind"
   The Run Interval and Lookbehind should equal the same number of minutes to avoid overlap, which could result in duplicate events.

* **Mute Period**: how long in minutes all future hits of the detection should be silenced
* **Daily Schedule**: specific days and hours to run detection from

### _Exclusions_
* **New Exclusion**: define specific exclusions to the detection without modifying the base query

### _Field Settings_
* **Signature Fields**: create unique signatures on this detection that will stack duplicates into one card for easier identification
   * Click `Clone From Input` to automatically generate these signatures from the Input
* **[Field Templates](../field-templates/index.md)**: define fields used to map values to an Observable when consuming data from an Input or creating an Event from a Detection
* **Additional Fields**: individually provide any other additional relevant fields

### _Meta Information_
* **MITRE Tactics**: identify the specific MITRE ATT&CK Tactic(s) to tag to alerts of this detection
* **MITRE Techniques**: identify the specific MITRE ATT&CK Technique(s) to tag to alerts of this detection
* **References**: link additional resources to help analysts understand the detection

!!! note "CVE References"
   Entering a CVE number as a reference will automatically pull the top five CVE reference URLs.

### _Triage Guide_
* **Triage Guide**: provide a guide for analysts to reference that will allow them to determine the legitimacy of the event and how/when to alert the customer
* **False Positives**: identify any false positives that can occur with the detection to help analysts quickly rule out false positive activity

### _Setup Guide_
* **Setup Guide**: provide a description to your customers of prerequisite data and configuration needed for this detection rule to be implemented

### _Testing Guide_
* **Testing Guide**: provide a description on how the detection rule can be tested to ensure it is functioning as expected

### _Review_
* The final step to creating a detection rule: review it then click `Create`.

<!--## How to leverage Detections?-->
## Leveraging Detections
See [Repositories](repositories.md) for how to leverage detections effectively with your customers.




