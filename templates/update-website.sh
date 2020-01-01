set -xe

# Generate package.min.json and store it
cd {{ bot_base_path }}/cdnjs
packages generate > /tmp/out.json
packages set < /tmp/out.json

# Wait until gcp storage is okay (FIXME)
sleep 300

cd {{ bot_base_path }}/new-website
if [[ $(git status --porcelain ./sri | wc -l) -gt 0 ]]; then
    # The package generation has likely added new SRIs; commit them, if any
    git add ./sri
    git commit -am "update SRIs"
    git push origin master
    git push heroku-api master
    git push heroku-web master
else
    # Else just restart the apps to pickup the new package.min.json
    heroku dyno:restart --app cdnjs-new-website2
    heroku dyno:restart --app cdnjs-api2
fi

# Update Algolia index (website search)
algolia update
