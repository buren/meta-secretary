#!/bin/bash
set -e

if [[ -z $META_SECRETARY_URL ]];then
  echo "The variable META_SECRETARY_URL must be set!"
  echo "Exiting..."
  exit 1
fi

echo 'Sending POST request to meta-secretary'
curl -X POST -d \
'{
  "deployment": {
    "commit_sha": "'$(git rev-parse HEAD)'",
    "tag": "'$(git describe)'",
    "server": "production",
    "application": "meta-secretary",
    "repository_name": "meta-secretary",
    "ip_address": ""
  }
}' $META_SECRETARY_URL/new_deployment --header "Content-Type:application/json" \
&& echo 'POST request sent' || echo "POST request to $META_SECRETARY_URL/new_deployment failed"
echo "Pushing master branch to heroku"
git push heroku master
