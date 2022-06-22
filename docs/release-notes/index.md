# Release Notes

## 2022.07.00

### Bugs

- Fix for [reflex-api#196](https://github.com/reflexsoar/reflex-api/issues/196) - The Audit Logs would not displayed correctly in the System > Settings > Audit Logs tab due to an issue with the `ip_approved` route decorator
- Fix for [reflex-api#194](https://github.com/reflexsoar/reflex-api/issues/194) - When deleting a user their e-mail was preserved and could not be re-used when making a new user.  When a user is deleted now the soft-deleted user will have their email set to `None`


### Features

- First release of Detections

### Enhancements

- Event Bulk Ingest now uses a pool of Memcached clients instead of spawning a new client per bulk ingest request.  This is a performance enhancement and a bug fix, the previous method was exhausting available TCP ports.

## 2022.06.00

### Bugs

- Fix for [reflex-api#198](https://github.com/reflexsoar/reflex-api/issues/198) - Unable to delete a User Role from the UI
- Fix for [reflex-api#199](https://github.com/reflexsoar/reflex-api/issues/199) - When the default admin user is left off the Organization creation wizard, organization creation fails
- Fix for [reflex-api#163](https://github.com/reflexsoar/reflex-api/issues/163) - Agent connections using the `elasticsearch` distribution on inputs were failing to establish connections to due to changes in how Elasticsearch handles connection creation

### Features

### Enhancements