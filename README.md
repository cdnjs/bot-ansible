# cdnjs-autoupdate-ansible

## Deploy

```
ansible-playbook [env].yml -i prod --ask-vault-pass
```

where [env] is:
- autoupdater: the bot that updates the cdnjs/cdnjs repo
