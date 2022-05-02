# Overview
Credentials is a central location to store secrets allowing ReflexSOAR and all it's components to authenticate to other systems.

## Security

!!! danger Use a strong Master Password
    It is up to the installer of ReflexSOAR to set a strong Master Password for password encryption.  It also your responsibility to prevent unauthorized access to `instance/application.conf`

ReflexSOAR uses `PBKDF2` with `100,000` iterations to encrypt each secret in the database.  The secret key is stored in `reflex-api` `instance/application.conf` file using the `MASTER_PASSWORD` parameter.  

## Password Decryption

!!! warning Decryption Potential
    It is recommended to monitor the activity of the users with `decrypt_credential` permissions and to tightly control who has this permission.

Secrets/Passwords are decryptable via the API using for any user that has the `decrypt_credential` permission.  By default all ReflexSOAR agents have this permission in order to function.