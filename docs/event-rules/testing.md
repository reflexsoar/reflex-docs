# Testing
Event Rules support retroactively testing them against the entire collection of Events in the system. This means that Reflex will attempt to test the Rule against all events in *any* state.

!!! note
    In multi-tenant environments, if the Global Rule is switched to `YES`, then the test will be done across *all* tenants.

## Best Practices
Because testing across a large set of events is time consuming, it is recommended to fine tune the testing criteria by selecting a relevant start and end date as well as adjusting the `Number of test events` to something reasonable (which is `1,000` Events by default).