variable "github_token" {}

locals {
  nodis   = "nodis-com-br"
  ptonini = "ptonini"
}

provider "github" {
  alias = "nodis"
  owner = local.nodis
  token = var.github_token
}

provider "github" {
  alias = "ptonini"
  owner = local.ptonini
  token = var.github_token
}


module "workflow_deploy_helm_release" {
  source  = "./modules/github_repository_file"
  topics  = ["helm-release github-flow"]
  file    = ".github/workflows/deploy.yml"
  content = file("src/deploy-helm-release.yml")
  owner   = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_apply_helm_release" {
  source  = "./modules/github_repository_file"
  topics  = ["helm-release github-flow"]
  file    = ".github/workflows/apply.yml"
  content = file("src/apply-helm-release.yml")
  owner   = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_apply_helm_release_collection" {
  source  = "./modules/github_repository_file"
  topics  = ["helm-collection github-flow"]
  file    = ".github/workflows/apply.yml"
  content = file("src/apply-helm-release-monorepo.yml")
  owner   = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_publish_docker_image" {
  source  = "./modules/github_repository_file"
  topics  = ["docker-image github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-docker-image.yml")
  owner   = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_publish_go_application" {
  source  = "./modules/github_repository_file"
  topics  = ["vault-plugin github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-go-application.yml")
  owner   = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_publish_python_package" {
  source   = "./modules/github_repository_file"
  topics   = ["package github-flow", "library github-flow"]
  language = "python"
  file     = ".github/workflows/publish.yml"
  content  = file("src/publish-python-package.yml")
  owner    = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_publish_lua_rock" {
  source  = "./modules/github_repository_file"
  topics  = ["kong-plugin github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-lua-rock.yml")
  owner   = local.nodis
  providers = {
    github = github.nodis
  }
}

module "workflow_publish_helm_monorepo" {
  source  = "./modules/github_repository_file"
  topics  = ["helm-charts github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-helm-chart-monorepo.yml")
  owner   = local.ptonini
  providers = {
    github = github.ptonini
  }
}

module "workflow_publish_docker_monorepo" {
  source  = "./modules/github_repository_file"
  topics  = ["docker-images github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-docker-monorepo.yml")
  owner   = local.ptonini
  providers = {
    github = github.ptonini
  }
}

module "workflow_publish_docker_image2" {
  source  = "./modules/github_repository_file"
  topics  = ["docker-image github-flow"]
  file    = ".github/workflows/publish.yml"
  content = file("src/publish-docker-image.yml")
  owner   = local.ptonini
  providers = {
    github = github.ptonini
  }
}