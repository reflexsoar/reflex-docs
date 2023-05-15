# Detection Repositories
Detection Repositories allow you to become a global tenant to share detection rules with your sub tenants. This means your customers won't have to manually create their own detection rules, and that any new detection rules you create will automatically be applied to the respective customer(s).

## Creating Detection Repositories
To create new detection repositories, the followings steps can be used:
1. Navigate to the Detections page
2. Click `Detection Repositories`
3. Click `New Repository`
3. Click `Create` after filling out the necessary information

## Repository Types
There are two types of repositories:
- `local`: 
- `remote`: 

## Access Permissions
There are two access permissions available per type:
### `local`
* `private`: 
* `local-shared`: 
    * *Access Scope*: defines what Organizations can access and synchronize the detections in the repository; when this is left empty, all tenants in the ReflexSOAR instance can access and synchronize the detection repository.
### `remote`
* `remote-private`:
* `remote-public`:

---

## Common Questions
1. What happens when access is revoked to a repository?
    * When access to a detection repository is revoked, all the previously synchronized rules are unlinked from the repository and can now be directly edited.

2. What counts as access revocation?
    * If the author of the detection repository removes your organization from the repository's access scope
    * If the author of the detection repository deletes the repository