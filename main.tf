variable "github_token" {}

locals {
  owner = "ptonini"
}

provider "github" {
  owner = local.owner
  token = var.github_token
}


# Github flow

module "repo_group_github_flow" {
  source  = "ptonini/repository-group/github"
  version = "~> 1.0.0"
  topics  = ["github-flow"]
  owner   = local.owner
}

resource "github_actions_variable" "container_registry" {
  for_each      = module.repo_group_github_flow.this
  repository    = each.key
  variable_name = "container_registry"
  value         = "ghcr.io/${local.owner}"
}

resource "github_actions_variable" "rp_manifest_file" {
  for_each      = module.repo_group_github_flow.this
  repository    = each.key
  variable_name = "rp_manifest_file"
  value         = ".release-please-manifest.json"
}

resource "github_actions_variable" "go_version" {
  for_each      = module.repo_group_github_flow.this
  repository    = each.key
  variable_name = "go_version"
  value         = "1.18"
}

resource "github_actions_variable" "python_version" {
  for_each      = module.repo_group_github_flow.this
  repository    = each.key
  variable_name = "python_version"
  value         = "3.9.12"
}

resource "github_actions_variable" "nodejs_version" {
  for_each      = module.repo_group_github_flow.this
  repository    = each.key
  variable_name = "nodejs_version"
  value         = "16.10.0"
}

resource "github_actions_variable" "lua_version" {
  for_each      = module.repo_group_github_flow.this
  repository    = each.key
  variable_name = "lua_version"
  value         = "5.4.4"
}


# Helm charts

module "workflow_publish_helm_charts" {
  source     = "ptonini/repository-file/github"
  version    = "~> 1.0.0"
  repository = { name = "helm-charts", default_branch = "main" }
  file       = ".github/workflows/publish-monorepo.yml"
  content    = file("src/publish-charts-monorepo.yml")
}


# Luarocks

module "workflow_publish_luarocks" {
  source     = "ptonini/repository-file/github"
  version    = "~> 1.0.0"
  repository = { name = "luarocks", default_branch = "main" }
  file       = ".github/workflows/publish-monorepo.yml"
  content    = file("src/publish-luarocks-monorepo.yml")
}


# Container images (monorepo)

module "workflow_publish_container_images" {
  source     = "ptonini/repository-file/github"
  version    = "~> 1.0.0"
  repository = { name = "container-images", default_branch = "main" }
  file       = ".github/workflows/publish-monorepo.yml"
  content    = file("src/publish-docker-monorepo.yml")
}


# Container image

module "repo_group_container_image" {
  source  = "ptonini/repository-group/github"
  version = "~> 1.0.0"
  topics  = ["container-image github-flow"]
  owner   = local.owner
}

module "workflow_publish_container_image" {
  source     = "ptonini/repository-file/github"
  version    = "~> 1.0.0"
  for_each   = module.repo_group_container_image.this
  repository = each.value
  file       = ".github/workflows/publish.yml"
  content    = file("src/publish-docker.yml")
}

resource "github_actions_variable" "pr_approved_tag" {
  for_each      = module.repo_group_container_image.this
  repository    = each.key
  variable_name = "pr_approved_tag"
  value         = "pr-approved"
}