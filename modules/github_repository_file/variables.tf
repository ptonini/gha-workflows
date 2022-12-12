variable "owner" {}

variable "topics" {
  default = []
}

variable "language" {
  default = null
}

variable "repository" {
  default = null
}

variable "file" {}

variable "content" {}

variable "commit_message" {
  default = null
}

variable "commit_author" {
  default = "terraform"
}

variable "commit_email" {
  default = null
}

variable "overwrite_on_create" {
  default = true
}