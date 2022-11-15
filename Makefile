include .env

## Credenciais
ACCESS_KEY=${ACCESS_KEY_ID}
SECRET_ACCESS=${SECRET_ACCESS_KEY}

## Image docker
TERRAFORM_VERSION=1.3.0-alpha20220622
DOCKER_IMAGE=hashicorp/terraform:${TERRAFORM_VERSION}

## Root module
PWD=$$PWD

## Workspace
WORKSPACE=${SET_WORKSPACE}

## Initial
terraform: terraform-workspace
	docker run --rm -v ${PWD}:/app -w /app \
	-e AWS_ACCESS_KEY_ID=${ACCESS_KEY} \
	-e AWS_SECRET_ACCESS_KEY=${SECRET_ACCESS} \
	-it --entrypoint "" ${DOCKER_IMAGE} sh

## Set workspace 
terraform-workspace:
	docker run --rm -v ${PWD}:/app -w /app \
	-e AWS_ACCESS_KEY_ID=${ACCESS_KEY} \
	-e AWS_SECRET_ACCESS_KEY=${SECRET_ACCESS} \
	-d ${DOCKER_IMAGE} workspace select ${WORKSPACE} \
	Selected worksplace ${WORKSPACE}