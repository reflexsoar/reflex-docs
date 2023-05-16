# Detection Repositories
Detection Repositories allow you to become a global tenant to share detection rules with your sub tenants. This means your customers won't have to manually create their own detection rules, and that any new detection rules you create will automatically be applied to the respective customer(s).

## Creating Detection Repositories
To create new Detection repositories, the followings steps can be used:

1. Navigate to the Detections page
2. Click `Detection Repositories`
3. Click `New Repository`
3. Click `Create` after filling out the necessary information

## Repository Types
There are two types of repositories:

- `local`: exist in the Reflex tenant and can be shared cross-organization
- `remote`**: exist in the Reflex tenant and can be shared across other Reflex instances

***`remote` repositories are still in development and will be coming to production soon!*

## Access Permissions
There are two access permissions available per type:

### `local`
* `private`: only accessible by your organization
* `local-shared`: accessible to all tenants in the Reflex instance
    * *Access Scope*: defines what Organizations can access and synchronize the Detections in the repository. By default, this is left empty, meaning all tenants in the ReflexSOAR instance can access and synchronize the detection repository.

### `remote`**
* `external-private`: accessible with an access key and URL
* `external-public`: accessible by anyone with the URL

---

## Common Questions
1. What happens when access is revoked to a repository?
    * When access to a detection repository is revoked, all the previously synchronized rules are unlinked from the repository and can now be directly edited.

2. What counts as access revocation?
    * If the author of the detection repository removes your organization from the repository's access scope
    * If the author of the detection repository deletes the repository

3. If I subscribe to a Detection Repository, can I pick and choose which detections to use?
    * No; a Detection provide by a subscribed repository cannot be modified or deleted unless you unsubscribe from the Repository first. Then, a copy of the Detection will be made available for modification or deletion.

!!! note "Synchronization Settings"
    Although you can choose to turn off specific settings from synchronizing with the repository, you can NOT turn the query off from synchronization. Utilizing Exclusions is the best way to make Detection repositories work best for your Organization.