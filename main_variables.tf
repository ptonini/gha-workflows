# Organization variables ######################################################

module "variable_container_registry" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "container_registry"
  value  = "ghcr.io/${local.owner}"
  owner  = local.owner
}

module "variable_pr_approved_tag" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "pr_approved_tag"
  value  = "pr-approved"
  owner  = local.owner
}

module "variable_rp_manifest_file" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "rp_manifest_file"
  value  = ".release-please-manifest.json"
  owner  = local.owner
}

module "variable_k6_test_file" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "k6_test_file"
  value  = "k6_tests.js"
  owner  = local.owner
}

module "variable_go_version" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "go_version"
  value  = "1.18"
  owner  = local.owner
}

module "variable_python_version" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "python_version"
  value  = "3.9.12"
  owner  = local.owner
}

module "variable_nodejs_version" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "nodejs_version"
  value  = "16.10.0"
  owner  = local.owner
}

module "variable_lua_version" {
  source = "./modules/github_repository_variable"
  topics = ["github-flow"]
  name   = "lua_version"
  value  = "5.4.4"
  owner  = local.owner
}