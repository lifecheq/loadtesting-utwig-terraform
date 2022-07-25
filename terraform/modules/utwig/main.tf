terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 5.0.2"
    }
  }
}

resource "heroku_app" "utwig" {
  name   = var.app_name
  region = "eu"
  organization {
    name = "lifecheq"
  }
}

resource "heroku_app_release" "release" {
  app_id  = heroku_app.utwig.id
  slug_id = var.slug_id
}

resource "heroku_formation" "utwig" {
  app_id     = heroku_app.utwig.id
  type       = "web"
  quantity   = var.dynos
  size       = var.dyno_size
  depends_on = [heroku_app_release.release]
}

resource "heroku_addon" "database" {
  app_id = heroku_app.utwig.id
  plan   = var.dbplan
}

resource "heroku_app_config_association" "utwig" {
  app_id         = heroku_app.utwig.id
  vars           = var.ordinary_vars
  sensitive_vars = var.sensitive_vars
}

resource "heroku_team_collaborator" "utwig-collaborator" {
  for_each    = var.operators
  app_id      = heroku_app.utwig.id
  email       = each.key
  permissions = ["view", "deploy", "operate", "manage"]
}
