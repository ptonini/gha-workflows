locals {
  base_query = "org:${var.owner} archived:false"
}

data "github_repositories" "this" {
  for_each = toset(var.topics)
  query    = "${each.value} in:topics ${local.base_query}"
}

data "github_repository" "this" {
  for_each = toset(flatten([for t in var.topics : [for r in data.github_repositories.this[t].names : r]]))
  name     = each.value
}

resource "github_actions_variable" "this" {
  for_each      = data.github_repository.this
  repository    = each.key
  variable_name = var.name
  value         = var.value
}