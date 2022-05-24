#!/usr/bin/env sh

set -e

yarn build

cd dist

git init
git add -A
git commit -m 'New Deployment'
git push -f git@github.com:kiril6/frontend-coding-challenge.git master:gh-pages

cd -