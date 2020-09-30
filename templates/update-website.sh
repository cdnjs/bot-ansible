#!/bin/bash

export SENTRY_DSN={{ sentry_dsn }}

set -xe

# Generate package.min.json and store it
cd {{ bot_base_path }}/cdnjs
BOT_BASE_PATH={{ bot_base_path }} packages generate > /tmp/out.json
packages set < /tmp/out.json

cd {{ bot_base_path }}/SRIs

# If there are any changes to SRIs
CHANGED=$(git status --porcelain)
if [ -n "${CHANGED}" ]; then
    git add .
    git commit -am "update SRIs"
    git push origin master
fi
