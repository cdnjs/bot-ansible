# cdnjs-autoupdate-ansible

## Hardware recommandation

- Low latency and fast disk (https://cloud.google.com/compute/docs/disks/performance).
- Multi cores < 7

## Deploy

```
ansible-playbook [env].yml -i prod --ask-vault-pass
```

where [env] is:
- autoupdater: the bot that updates the cdnjs/cdnjs repo

## Create a new instance

- on Google Cloud Platform; compute engine
    - select an instance of at least 30Gb of memory
    - add an additional disks: Local SSD scratch disk via NVMe of 375Gb
    - add your SSH key
- in this repo; update ansible inventory
- on the instance; login to heroku

- On Google Cloud Platform; update the log router `cdnjs-logs-exporter` to match
the new instance id.
