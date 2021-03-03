variable "profile" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "external_ip" {
  type    = string
  default = "74.69.167.125/32"
}

variable "desired_task_cpu" {
  type        = string
  description = "desired cpu to run your tasks"
  default     = "256"
}

variable "desired_task_memory" {
  type        = string
  description = "desired memory to run your tasks"
  default     = "512"
}


variable "environment_variables" {
  type        = map(string)
  description = "ecs task environment variables"

  default = {
    KEY = "value"
  }
}

variable "git_repository" {
  type        = map(string)
  description = "git repo owner, name, and branch"

  default = {
    owner  = ""
    name   = ""
    branch = "main"
  }
}

variable "domain_name" {
  type        = string
  description = "Domain name for AWS Route53 hosted zone"
}

variable "prefix" {
  description = "This is the environment where your webapp is deployed. qa, prod, or dev"
}

variable "vpc_cidr" {
  description = "base cidr for vpc created for environment"
}

variable "oauth_token" {
  description = "This is the oauth token used by AWS CodePipeline to access the repo"
}

variable "use_tls" {
  type        = bool
  description = "whether we would like to use a cert or not"
}

variable "url" {
  type        = string
  description = "base url to use for the app"
}


