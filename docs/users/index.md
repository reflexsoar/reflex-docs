# Users
Just like your computer, Reflex utilizes Users for several reasons. To begin, User accounts ensure that only authorized individuals can access specific resources or perform specific actions within the system. User accounts also provide a way to actively monitor User activity in the system, effectively creating accountability for actions conducted by your Users. Finally, by implementing Users in the Reflex system, multiple individuals can utilize the Reflex system effectively and efficiently.

## User Types
There are two types of User accounts in the Reflex system: *Users* and *Service Accounts*.

### *Users*

* **Users** are human operated accounts that are used to interact with the system via the User Interface.  They can use their API Bearer Token to interact with the API, but they should note that User API keys expire much quicker than service account keys (default `6` hours).  These accounts are governed by other policies like multi-factor authentication (MFA).

### *Service Accounts*

* **Service Accounts** are for the persistent programmatic access to the API.  Service Account API keys are issued upon creation and never stored by the API.  They expire by default after `365` days.

## User Roles
See [Roles](../role-based-access/roles.md) for more information on what User Roles exist in the Reflex system. These Roles play a critical part in maintaining proper [role-based access control](../role-based-access/index.md) over the Reflex system.


