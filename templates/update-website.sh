set -x

# Generate package.min.json and store it
cd {{ bot_base_path }}/cdnjs
packages generate > /tmp/out.json
packages set < /tmp/out.json

# Wait until gcp storage is okay (FIXME)
sleep 300

# Restart website and api to use the new package.min.js
heroku dyno:restart --app cdnjs-new-website2
heroku dyno:restart --app cdnjs-api2

# Update Algolia index (website search)
cd {{ bot_base_path }}/new-website
algolia update
