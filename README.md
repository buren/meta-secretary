# Meta secretary
Simple Rails app that keep track of deploys.

[![Code Climate](https://codeclimate.com/github/trialbee/meta-secretary.png)](https://codeclimate.com/github/trialbee/meta-secretary)
[![Build Status](https://travis-ci.org/trialbee/meta-secretary.png?branch=master)](https://travis-ci.org/trialbee/meta-secretary)

- [About](#about)
- [Create deploy](#create-deploy)
- [Production setup](#production-setup)
- [Contributing](#contributing)
- [Tests](#tests)
- [Technology](#technology)
- [MIT License](LICENSE)

## About
Meta Secretary is a simple Rails app, deployable in minutes, that keep track of deploys for code hosted on GitHub.

Prerequisites:
* A GitHub user token with access to all deployed repositories is needed, note that it can't be a organization token.

## Create deploy
```bash
# Required: commit_sha, application, repository_name, server
# Optional: ip_address, tag
#
# repository_name must be the name used on GitHub
#
#

$ curl -X POST -d \
'{
  "deployment": {
    "commit_sha": "8b988e7f73f07a50c4856bf86cd9aebaae06a032",
    "server": "meta-production-server",
    "application": "meta-secretary",
    "repository_name": "meta-secretary",
    "tag": "",
    "ip_address": ""
  }
}' https://example-meta.herokuapp.com/new_deployment --header "Authorization: Token token=$META_ACCESS_TOKEN" --header "Content-Type:application/json"
```
note that you need to change the authorization token.

## Production Setup
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Or you can deploy manually:
```bash
# Rails secret token
export SECRETARY_SECRET_TOKEN=$(rake secret)
$ git clone git@github.com:trialbee/meta-secretary.git
# If you want to deploy to Heroku:
$ heroku apps:create example-meta # choose a name
$ git push heroku master
$ heroku run rake db:create
$ heroku run rake db:migrate
$ heroku restart
```

## Updating Meta Secretary
```bash
$ export $META_SECRETARY_URL='https://example-meta.herokuapp.com'
$ export $META_ACCESS_TOKEN='...'
$ bash --login deploy.sh
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

For groupdate gem: time zone [support](http://dev.mysql.com/doc/refman/5.6/en/time-zone-support.html) needs to be added to MySQL
```bash
$ mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
```

### Tests

```bash
$ rspec # Will run all tests with coverage (output saved to coverage/)
# Or if you'd like to run relevant tests automatically on any file change
$ guard
```

## Technology

* Ruby 2.0 (works with Ruby 2.1 & 1.9.3)
* Ruby on Rails 4.0
* MySQL      (development)
* PostgreSQL (production)
* Twitter Bootstrap 3.1.1
* jQuery 1.10
* jQuery.dataTables 1.9.4
* Handlebars.js 1.3.0
* Unicorn 4.8 (application server)
