provider "aws" {
  profile = var.profile
  region  = var.primary-region
  alias   = "main-account"
}

module "network" {
  #source = "./network"
  source    = "github.com/npc-code/toy_terraform_network.git"
  profile   = var.profile
  region    = var.primary-region
  base_cidr = "${var.vpc_cidr}"

  providers = {
    aws = aws.main-account
  }
}

module "ecs" {
  #source = "./ecs"
  source                = "github.com/npc-code/toy_ecs_code_pipeline.git"
  cluster_name          = "${var.prefix}-cluster"
  container_name        = "${var.prefix}-container"
  container_port        = 5000
  environment_variables = var.environment_variables
  desired_task_cpu      = var.desired_task_cpu
  desired_task_memory   = var.desired_task_memory
  desired_tasks         = 2
  external_ip           = var.external_ip
  vpc_id                = module.network.vpc_id
  alb_port              = 80
  region                = var.primary-region
  ecr_repo_name         = "${var.prefix}-ecr-repo"
  availability_zones    = ["${module.network.public_subnet_1_id}", "${module.network.public_subnet_2_id}"]
  providers = {
    aws = aws.main-account
  }
}

module "pipeline" {
  source = "github.com/npc-code/toy_terraform_code_pipeline.git"
  region = var.primary-region

  cluster_name   = "${var.prefix}-cluster"
  repository_url = module.ecs.ecr_webapp_repository_url
  container_name = "${var.prefix}-container"

  subnet_ids = ["${module.network.public_subnet_1_id}", "${module.network.public_subnet_2_id}"]
  vpc_id     = module.network.vpc_id

  app_repository_name = module.ecs.ecr_webapp_repository_name
  app_service_name    = "${var.prefix}-cluster"
  pipeline_name       = "${var.prefix}-container-pipeline"

  bucket_name    = "${var.prefix}toygithubflask"
  project_name   = "${var.prefix}-flask-codebuild"
  git_repository = var.git_repository
  oauth_token    = var.oauth_token


  providers = {
    aws = aws.main-account
  }
}

