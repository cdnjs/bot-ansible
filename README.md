# cdnjs-autoupdate-ansible

## Deploy

```
ansible-playbook [env].yml -i prod --ask-vault-pass
```

where [env] is:
- autoupdater: the bot that updates the cdnjs/cdnjs repo

## Add secrets var

```
ansible-vault encrypt_string --ask-vault-pass --name NAME
```

Copy the output and add it to `./vars.yml`

## Add encrypted file

```
ansible-vault encrypt files/clear.crt --ask-vault-pass
```
