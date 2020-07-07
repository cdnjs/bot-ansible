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

# Wait until gcp storage is okay (FIXME)
sleep 300

# Go to website
cd {{ bot_base_path }}/new-website

# Check if there are changes from upstream
if ! git diff --quiet remotes/origin/HEAD; then
    # Pull for new modifications
    git pull origin master --rebase
    git submodule update --remote --recursive

    # Push them to heroku, which will also trigger a restart
    git push heroku-web master
else
    # Restart apps to pick up new eventual changes
    heroku dyno:restart --app cdnjs-new-website2
fi

# Update Algolia index (website search)
algolia update
