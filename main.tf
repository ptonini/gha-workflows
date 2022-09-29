variable "github_token" {}

locals {
  github_owner = "nodis-com-br"
}

provider "github" {
  owner = local.github_owner
  token = var.github_token
}

module "workflow_deploy_helm_release" {
  source  = "git@github.com:nodis-com-br/tf_modules.git//github_repository_file"
  topics  = ["helm-release github-flow"]
  file    = ".github/workflows/deploy.yml"
  content = file("src/deploy-helm-release.yml")
  owner   = local.github_owner
}

module "workflow_configure_helm_release" {
  source  = "git@github.com:nodis-com-br/tf_modules.git//github_repository_file"
  topics  = ["helm-release github-flow"]
  file    = ".github/workflows/configure.yml"
  content = file("src/configure-helm-release.yml")
  owner   = local.github_owner
}

module "workflow_publish_docker_image" {
  source  = "git@github.com:nodis-com-br/tf_modules.git//github_repository_file"
  topics  = ["docker-image github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-docker-image.yml")
  owner   = local.github_owner
}

module "workflow_publish_go_application" {
  source  = "git@github.com:nodis-com-br/tf_modules.git//github_repository_file"
  topics  = ["vault-plugin github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-go-application.yml")
  owner   = local.github_owner
}

module "workflow_publish_python_package" {
  source   = "git@github.com:nodis-com-br/tf_modules.git//github_repository_file"
  topics   = ["package github-flow", "library github-flow"]
  language = "python"
  file     = ".github/workflows/publish.yml"
  content  = file("src/publish-python-package.yml")
  owner    = local.github_owner
}

module "workflow_publish_lua_rock" {
  source  = "git@github.com:nodis-com-br/tf_modules.git//github_repository_file"
  topics  = ["kong-plugin github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-lua-rock.yml")
  owner   = local.github_owner
}