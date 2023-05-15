# Case Templates
Case Templates serve as a valuable tool for adding structure to your investigations. They provide a quick and easy way to ensure that each time a [Case](cases.md) is opened, it adheres to a predefined process.

## Creating Case Templates
To create a new Case Template, the following steps can be used:
1. Navigate to the Cases page
2. Click `Case Templates`
3. Click `New Case Template`
4. Enter the Case Template Details and Tasks
5. Click `Create`

## Template Details
![Create case template screenshot](../img/create_case_template.png)

### *Organization*
* Select the appropriate Organization from the drop-down list. Unless you are leveraging the multitenancy function of Reflex, you may only have one option available here.

### *Case Title and Description*
* Provide a title and description for your Case Template to make it easier to locate and utilize. For example, the Case Template title of `Phishing` could have a description of `This Case Template can be used for investigating potential phishing attacks.`

### *TLP*
* Define the [Traffic Light Protocol (TLP)](https://www.cisa.gov/tlp) to identify the sensetivity level of information contained in these types of cases.
    * **RED**: Not for disclosure, restricted to participants only
    * **AMBER STRICT**: Limited disclosure, restricted to participants’ organization
    * **AMBER**: Limited disclosure, restricted to participants’ organization and its clients
    * **GREEN**: Limited disclosure, restricted to the community
    * **CLEAR**: Disclosure is not limited

### *Severity*
* Define the severity level you want associated with these types of cases/

### *Tags*
* Provide any additional tags that you would like to have included for the template.

## Tasks
Tasks can be created as part of the Case Template to define what steps an analyst should complete in order to conduct a proper investigation.

![Create case template task screenshot](../img/case_template_tasks.png)

### *Creating and ModifyingTasks*
1. Click the `+` next to Tasks
2. Enter a title and description of the Task
3. Click `Save`
4. Click `Edit` to edit the Task after saving
5. Click `Remove` to delete a Task
6. Repeat as many times as necessary

## Review
The final step is to review the information provided to create the Case Template. After you've finished reviewing the Case Template, click `Create`.

![Review case template screenshot](../img/case_template_review.png)

## Modifying and Deleting Case Templates
Case Templates can be modified or deleted at any point by using the following steps:
1. Navigate to the Cases page
2. Click `Case Templates`
3. Locate the Case Template
4. Click the appropriate action, either `Edit Template` or `Delete`
5. If editing the Template, click `Update` once finished