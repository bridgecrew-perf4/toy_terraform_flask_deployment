# toy_terraform_flask_deployment

A simple POC for working with AWS via Terraform.  Currently this will only work with a flask application running within docker, but further changes will make this more modular. This project will create:
- a vpc with 2 public and 2 private subnets across 2 azs
- an internet gateway and nat gateway for public and private subnet routes
- security groups for the alb and the fargate cluster
- appropriate IAM roles
- an alb, currently serving only http traffic
- a fargate cluster
- a codepipeline that uses codebuild to build the container and push to the created ecr, and then deploy the latest build to the fargate cluster
- if use_tls is set to true, will create an ACM cert for the passed domain.  requires a route53 public zone using a domain you own.

After the project is launched, going forward, commits made to the targeted repo will be automatically deployed on a successful build.

## Requirements
- AWS account 
- An IAM profile in the account with the necessary permissions
- Terraform
- A github repo to use as your target repository
- oauth token created on github with access to your target repository
- route53 public domain (further work will make this optional in child modules, but given the ease of use/cost, I would encourage having one)

## Dependencies
- https://github.com/npc-code/toy_ecs_code_pipeline
- https://github.com/npc-code/toy_terraform_code_pipeline
- https://github.com/npc-code/toy_terraform_network

## Installation
- Pull down the project, change into project directory, and execute: terraform init
- Create a workspace: terraform workspace new dev
- Create a variable file that will correspond to your workspace name: touch dev.tfvars
- Populate dev.tfvars with the necessary values

## Example .tfvar file
```hcl
region         = "us-east-2"
prefix         = "dev"
vpc_cidr       = "10.1.0.0/16"
oauth_token    = "your_token_here"
profile        = "your_iam_profile_name"
git_repository = { owner = "your_github_handle", name = "your_repo_name", branch = "main" }
domain_name    = "example.com"
use_tls        = true
url            = "dev.example.com"
```


## Use
- Execute: terraform plan -var-file=dev.tfvars
- Assuming no errors, execute: terraform apply -var-file=dev.tfvars
- drink coffee
- at end of execution, the DNS for the alb is displayed, navigate to this endpoint to access your app running in Fargate behind an alb.
- when finished, execute: terraform destroy -var-file=dev.tfvars.  THIS WILL DESTROY ALL RESOURCES CREATED BY THIS PROJECT.  

## DISCLAIMER
- some of the deployed resources will incur charges to your AWS account if you do not destroy your resources when finished.  I take no responsibility for charges incurred.
