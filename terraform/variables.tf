variable "prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "autoserve"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "docker_image_tag" {
  description = "Image tag to deploy"
  type        = string
  default     = "latest"
}

