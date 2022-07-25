terraform {
  backend "pg" {
  }
}

variable "loadtesting_utwig_sensitive_vars" {}
variable "loadtesting_utwig_ordinary_vars" {}

module "loadtesting-utwig" {
  source = "./modules/utwig"

  app_name       = "loadtesting-utwig"
  dbplan         = "heroku-postgresql:standard-0"
  dyno_size      = "Standard-2X"
  dynos          = 1
  ordinary_vars  = var.loadtesting_utwig_stage_sanlam_ordinary_vars
  sensitive_vars = var.loadtesting_utwig_stage_sanlam_sensitive_vars
  # FIXME: remove `slug_id` and build slug with terraform
  #
  # We are piggiebacking on another app, and getting the Heroku slug
  # from there. You'll need to fix this part.
  slug_id        = "YOUR_SLUG_HERE"
  drain_name     = "loadtesting-utwig"
  operators      = toset(["your.email@example.com","another.email@example.com"])
}
