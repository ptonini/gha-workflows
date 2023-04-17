locals {
  default_email   = "${var.commit_author}@users.noreply.github.com"
  default_message = "chore: ${var.file} created/modified by terraform [skip ci]"
  base_query      = "org:${var.owner} archived:false ${var.extra_query_params}"
  query           = var.language == null ? local.base_query : "${local.base_query} language:${var.language}"
}

data "github_repositories" "this" {
  for_each = toset(var.topics)
  query    = "${each.value} in:topics ${local.query}"
}

data "github_repository" "this" {
  for_each = toset(flatten([for t in var.topics : [for r in data.github_repositories.this[t].names : r]]))
  name     = each.value
}

resource "github_repository_file" "this" {
  for_each            = data.github_repository.this
  repository          = each.key
  branch              = coalesce(var.branch, each.value["default_branch"])
  file                = var.file
  content             = var.content
  commit_author       = var.commit_author
  commit_message      = coalesce(var.commit_message, local.default_message)
  commit_email        = coalesce(var.commit_email, local.default_email)
  overwrite_on_create = var.overwrite_on_create
}