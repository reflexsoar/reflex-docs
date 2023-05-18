# How-To Change the UI Certificate
By default, when ReflexSOAR is executed within a container, a self-signed certificate is generated during the image build process. However, certain users may prefer to replace this self-signed certificate with their own, CA-signed certificate, following best practices.

## Changing the UI Certificate (Docker)

### *Using Docker-Compose*

In your docker compose file, add the following lines:

```
volumes:
  - /path/to/your/cert.crt:/opt/reflex/ssl/server.crt
  - /path/to/your/cert.key:/opt/reflex/ssl/server.key
```

### *Using Docker Run*

If running your `reflex-ui` container using `docker run`, add the following volume parameters:

```
-v /path/to/your/cert.crt:/opt/reflex/ssl/server.crt -v /path/to/your/cert.key:/opt/reflex/ssl/server.key
```
