variable "project_id" {
  type = string
}

variable "alias" {
  type = string
}

variable "alias_id" {
  type = string
}

variable "subnets" {
  type = list(any)
}

variable "network" {
  type = string
}

variable "root_password" {
  type = string
}

variable "region" {
  type = string
}