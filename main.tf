variable "github_token" {}

locals {
  owner = "ptonini"
}

provider "github" {
  owner = local.owner
  token = var.github_token
}

module "workflow_publish_helm_monorepo" {
  source  = "./modules/github_repository_file"
  topics  = ["helm-charts github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-charts.yml")
  owner   = local.owner
}

module "workflow_publish_docker_monorepo" {
  source  = "./modules/github_repository_file"
  topics  = ["container-images github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-docker-monorepo.yml")
  owner   = local.owner
}