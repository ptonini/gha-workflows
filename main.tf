variable "github_token" {}

locals {
  owner = "ptonini"
}

provider "github" {
  owner = local.owner
}

module "workflow_publish_helm_monorepo" {
  source  = "modules/github_repository_file"
  topics  = ["helm-charts github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-helm-chart-monorepo.yml")
  owner   = local.owner
}

module "workflow_publish_docker_monorepo" {
  source  = "modules/github_repository_file"
  topics  = ["docker-images github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-docker-monorepo.yml")
  owner   = local.owner
}