# Users
[ put a little description here ]

## User Types
There are two types of users in the Reflex System: Users and Service Accounts.

### *Users*

* Users are human operated accounts that are used to interact with the system via the User Interface.  Users can use their API Bearer token to interact with the API but they should note that User API keys expire much quicker than service account keys (default `6` hours).  User accounts are governed by other policies like Multi-Factor authentication.

### *Service Accounts*

* Service Accounts are for the persistent programmatic access to the API.  Service Account API keys are issued upon creation and never stored by the API.  They expire by default after `365` days.

## User Roles
There are 3 default User roles that exist in the system upon install:

!!! note "Default Organization Permissions"
    Some permissions may be different for the Admin and Analysts of the Default Organization due to multi-tenancy functionality.  Those permissions include `view_organizations`, `add_organization`, `update_organization`, `delete_organization`, `create_service_account`, `view_service_accounts`, `update_service_account`, `delete_service_account`


Role Name | Description | Default Permissions
--- | --- | ---
Admin | The administrator of the organization | All
Analyst | The analyst that interacts with the system on a daily basis | view_users,view_roles,add_tag,update_tag,delete_tag,view_tags,add_credential,update_credential,decrypt_credential,delete_credential,view_credentials,add_playbook,view_playbooks,add_tag_to_playbook,remove_tag_from_playbook,add_event,view_events,view_case_events,update_event,add_tag_to_event,remove_tag_from_event,add_observable,update_observable,delete_observable,add_tag_to_observable,remove_tag_from_observable,add_agent,view_agents,view_inputs,create_case,view_cases,update_case,create_case_comment,view_case_comments,update_case_comment,view_plugins,view_agent_groups,view_user_groups,create_case_template,view_case_templates,update_case_template,delete_case_template,create_case_task,view_case_tasks,update_case_task,delete_case_task,view_settings,upload_case_files,view_case_files,delete_case_files,create_event_rule,update_event_rule,delete_event_rule,view_organizations,view_event_rules,create_detection,update_detection,view_detections,delete_detection,view_notification_channels,view_notifications,view_agent_policies
Agent | Reflex Agents - A reserved internal Role | decrypt_credential,view_credentials,view_playbooks,add_event,update_event,add_tag_to_event,remove_tag_from_event,add_observable,update_observable,delete_observable,add_tag_to_observable,remove_tag_from_observable,view_agents,view_plugins,add_event,view_settings,view_inputs,view_detections,update_input,update_detection,view_agent_policies,create_agent_log_message,view_agent_logs,