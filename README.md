# cdnjs-autoupdate-ansible

## Hardware recommandation

- Low latency and fast disk (https://cloud.google.com/compute/docs/disks/performance).
- Multi cores < 7

## Deploy

```
ansible-playbook [env].yml -i prod
```

where [env] is:
- autoupdater: the bot that updates the cdnjs/cdnjs repo
