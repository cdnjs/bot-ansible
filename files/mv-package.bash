#!/usr/bin/bash -xe

if [ -z "$1" ]
then
  echo "usage: mv-package NAME"
  exit 1
fi

cd /cdnjs-sven/cdnjs

firstLetter() {
  echo $1 | head -c 1 | awk '{print tolower($0)}'
}

sudo service cdnjs-bot stop || echo "service not running"

package=$1
char=$(firstLetter $package)
cdnjsPath="ajax/libs/$package/package.json"

mv $cdnjsPath "/cdnjs-sven/packages/packages/$char/$package.json"
git clean -d -f $(dirname $cdnjsPath)

cd /cdnjs-sven/packages

git add packages/$char/$package.json
git commit -m "move $package"
git push
