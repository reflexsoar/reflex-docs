# Testing

Event Rules support retro-actively testing them against the entire collection of events in the system.

## Testing Best Practices

!!! note
    In multi-tenant environments, if the Global Rule flag is checked the test will be across all tenants.

Because testing across a large set of events is time consuming, it is recommended to fine tune the testing criteria by selecting a start and end date and adjusting the `Number of test events` to something reasonable.