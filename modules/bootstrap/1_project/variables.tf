variable "org_id" {
  type = string
}

variable "billing_id" {
  type = string
}

variable "folder_id" {
  type = string
  
}

variable "department" {
  type = string
}

variable "environment" {
  type = string
}

variable "service_list" {
  type = list(any)
}