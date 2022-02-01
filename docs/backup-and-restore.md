# Backup and Restore

## Using `restore.py`

`restore.py` should be used in catastrophic scenarios.

1. Make sure all the Elasticsearch configuration environmental variables are set
2. Run `pipenv run python restore.py --dump -o backup.zip -p secret`
3. Stop the Reflex API
4. Set `REFLEX_RESTORE_MODE=true` in your environment variables
5. Delete all Reflex indices from Elasticsearch
6. Restart Reflex
7. Wait for initial index setup to complete
8. Run `pipenv run python restore.py -a backup.zip -p secret`
9. Stop Reflex
10. Unset `REFLEX_RESTORE_MODE`
11. Restart Reflex
