# Organizations
**Organizations** serve as a means for logical separation between entities in the Reflex system, allowing you to effectively organize your teams and clients. For instance, managed security service providers (MSSPs) offering managed detection and response (MDR) services to multiple customers can create distinct Organizations to readily identify and respond to each client individually. This structure enhances the efficiency and organization of operations within Reflex, facilitating seamless management for diverse clientele.

## Creating Organizations
To create a new Organization, the following steps can be used:

1. Navigate to the Settings page
2. Click `Organizations`
3. Click `New Organization`
4. Provide the name of the Organization
5. Provide a brief description of the Organization if necessary
6. Link the company's website if it exists
7. Enter the email domains that can be associated with Reflex accounts
8. Click `Next`
9. Provide the necessary information to create the first [Admin User](../users/index.md) for the Organization
10. Click `Create` after reviewing the Organization and Admin User details

!!! warning "Logon Domains"
    When entering the email domains that can be associated with Reflex accounts, be sure to include only one per line. **Admins can only create users with emails at the domains provided here.**

## Access Scope

* The `Default Organization` has access to **all** sub-Organizations and their information as an Administrator

* Sub-organization can only see their information

* Each organization must have it's own [Agents](../agents/index.md)

!!! note "Organization Agents"
    Agents can be paired to an Organization by fetching the pairing key as a User of the Organization, or by obtaining the Persistent Pairing Token from the Organization's Settings page.