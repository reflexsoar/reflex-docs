# SSO Troubleshooting

## Invalid Responses

If you get a message like below, it may mean you are running ReflexSOAR behind a proxy and some special configuration is required for SSO to work.

```
The response was received at http://localhost/api/v2.0/auth/sso/d3ad87b3-5af1-4b81-a57f-cfa905b2fe4a/acs instead of https://bc-dev-reflex.siemasaservice.com/api/v2.0/auth/sso/d3ad87b3-5af1-4b81-a57f-cfa905b2fe4a/acs
```

1. Enable `X_FORWARD_HOST` by setting `REFLEX_X_FORWARDED_HOST=true` in your environmental variables
2. Set `REFLEX_SSO_FORCE_HTTPS=true` in your environmental variables

These changes should force incoming requests via SSO to be prepared with the proper hostname and the `https` scheme.
