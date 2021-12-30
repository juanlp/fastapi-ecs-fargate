variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "memory" {
  type    = number
  default = 2048
}

variable "cpu" {
  type    = number
  default = 1024
}

variable "docker_image_url" {
  type = string
}