# How to change the UI Certificate

By default when running ReflexSOAR in a container, a self-signed certificate is generated during the container image build.  For some users they may want to replace this self-signed certificate with their own, CA signed certified (as is recommended by best practice).

## Changing the UI Certificate (Docker)

### Using docker-compose

In your docker compose file add the following

```
volumes:
  - /path/to/your/cert.crt:/opt/reflex/ssl/server.crt
  - /path/to/your/cert.key:/opt/reflex/ssl/server.key
```

### Using docker run

If running your `reflex-ui` container using `docker run` add the following volume parameters

```
-v /path/to/your/cert.crt:/opt/reflex/ssl/server.crt -v /path/to/your/cert.key:/opt/reflex/ssl/server.key
```
