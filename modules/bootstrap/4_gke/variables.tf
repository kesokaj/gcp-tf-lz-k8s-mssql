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

variable "subnets_all" {
  type = list(any)
}

variable "network" {
  type = string
}

variable "gke_sa" {
  type = string
}

variable "region" {
  type = string
}