### What

This is the terraform config used to provision one of our services.

Dynatrace support ticket: https://one.dynatrace.com/hc/en-us/requests/48018

The tl;dr of our issue is this:

Intermittently, when the service boots, OneAgent fails to detect the memory
settings of the container the service runs in, and this leads to all
of our host units being allocated to this one service.

Our workaround is to restart the Heroku dyno and hope that the memory
settings are correctly read.

### FIXME

This config relies on a Heroku slug being available. You'll need to
either build a slug separately, or fix this config to build your code
using another method.

The slug we deployed included an uberjar, as well as the following buildpacks:

- heroku/jvm
- https://github.com/Dynatrace/heroku-buildpack-dynatrace.git#v1.2

### Once off set up

Once for the whole system, to init Terraform.

Choosing Heroku DB as the Terraform backend.

```
export APP_NAME=terraform-backend
heroku create --region eu --team=$YOUR_HEROKU_ORG $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
export DATABASE_URL=`heroku config:get DATABASE_URL --app $APP_NAME`
make init
```

### Create/Update Load testing environment

Create a Heroku token:

```
heroku authorizations:create --description "Testing-terraform"
# Alternatively, just use `heroku auth:token`
```

We will need to grep the output or similar to get the token, or fetch it with another authorizations command line

```
export HEROKU_API_KEY=HEREYOURTOKEN HEROKU_EMAIL=HEREYOUREMAIL
```

Get the Terraform backend DB url:

```
export APP_NAME=terraform-backend
export DATABASE_URL=`heroku config:get DATABASE_URL --app $APP_NAME`
```

Create/update/awake the app:

```
make apply 
```
