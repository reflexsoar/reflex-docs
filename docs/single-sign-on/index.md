# Single Sign-On

## SAML Authentication Workflow

### Service Provider Initiated

1. User lands on the Login page of ReflexSOAR
2. User enters their e-mail and clicks `Login with SSO` instead of `Login`
3. The user is redirected to the `/api/v2.0/ssostart` endpoint where their SAML realm configuration is fetched
4. The user is redircted to their IdP for authentication
5. The user is redirected back to `/api/v2.0/sso/<organization_uuid>/acs`
6. An `access_token` and `refresh_token` are placed in the users cookies
7. The user is redirected to `/#/dashboard`
8. The `access_token` and `refresh_token` cookies are consumed and moved to Local Storage and the Authorization header is set
9. User is logged in

## Important Authentication Scenarios

- If a user is `locked` in ReflexSOAR and successfully authenticates via their Identity Provider, their access will be rejected in ReflexSOAR.
- If a user does not exist in ReflexSOAR and successfully authenticates via their Identity Provider, their access will be rejected in ReflexSOAR, unless Automatic User provisioning is enabled.

## Adding an SSO Realm

1. Navigate to **System** > **Settings** > **Authentication**
2. Select `Add Realm`
3. Configure the IdP `Entity ID`, `SignOn Service` URL and `Logout Service` URL
4. Add the `IdP` cert in CER format
5. Provide the logon domains for this realm (Note: Logon domains determine which SSO realm the user should authenticate to if there is more than one realm)
6. OPTIONAL - Enabled `Automatic User Provisioning`
7. OPTIONAL - Adjust Advanced Settings depending on the the IdP
8. Save the Realm

## Mapping Users to Roles

ReflexSOAR supports automatically mapping Identity Provider authenticted users to internal ReflexSOAR roles.  This can be accomplished by navigating to **Settings** > **Authentication** > **Role Mapping** > **Create Role Mapping** and supply the SAML attribute, a value to match and the role to map to. 

### Examples

Attribute | Value | Role
--- | --- | ---
groups | ReflexAdmins | Admin
groups | ReflexAnalysts | Analyst
groups | IT-* | Viewer

## Automatic User Provisioning

ReflexSOAR can be configured to automatically provision new users that the configured Identity Provider has authenticted. On the **User Provisioning** tab of the SSO Provider creation wizard check the box for `Auto Provision Users` and select the `Default Role`.

!!! note "Role Assignment"
    If you have configured Automatic Role mapping settings, a user's default roles will be adjusted to match their mapped roles and not the Default Role.

### Required SAML Attributes

Automatic User provisioning requires the SAML assertion to have all the required attributes for creating the user.  The table below highlights what is expected.

Attribute | Maps To
--- | ---
first_name | First Name
last_name | Last Name
email | E-mail
username | User Alias