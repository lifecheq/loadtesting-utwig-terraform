variable "app_name" {
  description = "Name of the Heroku app provisioned"
}

variable "slug_id" {
  description = "Heroku slug ID for API app"
  type        = string
}

variable "dynos" {
  description = "Number of dynos to run"
  type        = number
}

variable "dbplan" {
  description = "DB to use"
  type        = string
}

variable "dyno_size" {
  description = "Dyno size to run"
  type        = string
}

variable "ordinary_vars" {
  description = "Ordinary vars"
  type        = map(string)
}

variable "sensitive_vars" {
  description = "Sensitive vars"
  type        = map(string)
}

variable "operators" {
  description = "Used to grant operator access"
  type        = set(string)
}
