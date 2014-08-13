#!/bin/bash
set -e

if [[ -z $META_SECRETARY_URL || -z $META_ACCESS_TOKEN ]];then
  echo "Both META_SECRETARY_URL and META_ACCESS_TOKEN must be set!"
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
}' $META_SECRETARY_URL/new_deployment  --header "Authorization: Token token=$META_ACCESS_TOKEN" --header "Content-Type:application/json" \
&& echo 'POST request sent' || echo "POST request to $META_SECRETARY_URL/new_deployment failed"
echo "Pushing master branch to heroku"
git push heroku master
