# toy_terraform_flask_deployment

A simple POC for working with AWS via Terraform.  Currently this will only work with a flask application running within docker, but further changes will make this more modular.

## Requirements
- AWS account 
- An IAM profile in the account with the necessary permissions
- Terraform
- A github repo to use as your target repository
- oauth token created on github with access to your target repository

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


## Use
- Execute: terraform plan -var-file=dev.tfvars
- Assuming no errors, execute: terraform apply -var-file=dev.tfvars
- drink coffee
- at end of execution, the DNS for the alb is displayed, navigate to this endpoint to access your app running in Fargate behind an alb.
- when finished, execute: terraform destroy -var-file=dev.tfvars.  THIS WILL DESTROY ALL RESOURCES CREATED BY THIS PROJECT.  

## DISCLAIMER
- some of the deployed resources will incur charges to your AWS account if you do not destroy your resources when finished.  I take no responsibility for charges incurred.
