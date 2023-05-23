# Detection Repositories
**Detection Repositories** allow you to become a global tenant to share Detection Rules with your sub tenants. This means your customers won't have to manually create their own Detection Rules, and that any new Detection Rules you create will automatically be applied to the respective customer(s).

## Creating Detection Repositories
To create new Detection repositories, the followings steps can be used:

1. Navigate to the Detections page
2. Click `Detection Repositories`
3. Click `New Repository`
3. Click `Create` after filling out the necessary information

## Subscribing to a Repository
Subscribing to a Repository will automatically sync all Detections from the target Repository to your own Detection library. When subscribing to a Detection Repository, you can define a field called `Synchronization Interval (minutes)` which will determine how often you wish to synchronize new and updated Detections from the subscribed Repository.

!!! warning
    Any local changes that have been made to the Detection Repository will be overwritten during synchronization.

However, you can also choose which updates you would like to synchronize. Looking at the image below, there are certain fields you can choose to sync or not sync with the subscribed Repository. For example, you can choose to disable the synchronization of the Risk Score if you are happy with the original.

![Synchronization settings](../img/sync-settings.png)

!!! warning "Disabling Synchronization of the Base Query"
    One thing you can NOT disable is the synchronization of the Detection's base query. 

!!! warning "Deleting Detections from a Repository"
    Detections from a currently subscribed Repository can NOT be deleted from your library of Detections. If you wish to delete a Detection, you must first unsubscribe from the Repository. Utilizing Exclusions is the best way to make Detection Repositories work best for your Organization.

## Manual Synchronization
Even though Reflex with *automatically* synchronize subscribed Detection Repositories based on the `Synchronization Interval (minutes)` field, you can also choose to manually sync them at any point. To do this, the following steps can be used when logged into Reflex as the [Admin](../users/index.md) user:

1. Navigate to the Detections page
2. Click `Detection Repositories`
3. Click `Manage` on any of the Detections
4. Select `Synchronize Now`


## Repository Types
There are two types of Repositories:

- `local`: exist in the Reflex tenant and can be shared cross-organization
- `remote`**: exist in the Reflex tenant and can be shared across other Reflex instances

***`remote` Repositories are still in development and will be coming to production soon!*

## Access Permissions
There are two access permissions available per type:

### `local`
* `private`: only accessible by your organization
* `local-shared`: accessible to all tenants in the Reflex instance
    * *Access Scope*: defines what Organizations can access and synchronize the Detections in the Repository. By default, this is left empty, meaning all tenants in the ReflexSOAR instance can access and synchronize the Detection Repository.

### `remote`**
* `external-private`: accessible with an access key and URL
* `external-public`: accessible by anyone with the URL

***`remote` Repositories are still in development and will be coming to production soon!*

## Adding Detections to a Repository
When adding new Detections to the Default Organization, an [Agent](../agents/index.md) will automatically assess that Detection in a disabled state for 60 minutes. This ensures the Detection is not going to trigger an excessive amount of Events. Once the assessment is complete, if it is not flagged for high-volume, then it will automatically be enabled. Additionally, if the base query of the Detection is modified, the assessment process will repeat. 

---

## Q & A

*1. What happens when access is revoked to a Repository?*

* When access to a Detection Repository is revoked, all the previously synchronized rules are unlinked from the Repository and can now be directly edited.

*2. What counts as access revocation?*

* If the author of the Detection Repository removes your organization from the Repository's access scope
* If the author of the Detection Repository deletes the Repository

*3. If I subscribe to a Detection Repository, can I pick and choose which Detections to use?*

* No; a Detection provide by a subscribed Repository cannot be modified or deleted unless you unsubscribe from the Repository first. Then, a copy of the Detection will be made available for modification or deletion.

*4. How can I modify a Detection in a Repository to make it work for me?*

* The best way to leverage Detections derived from a Detection Repository is to utilize [Exclusions](index.md/#exclusions). To do this, locate the Detection Rule you wish to add an Exclusion to, click `Manage` | `Edit Detection`, select `Exclusions`, and click `New Exclusion`.