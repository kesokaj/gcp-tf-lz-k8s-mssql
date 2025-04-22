variable "project_id" {
  type = string
}

variable "alias" {
  type = string
}

variable "subnets" {
  type = list(any)
}

variable "network" {
  type = string
  
}