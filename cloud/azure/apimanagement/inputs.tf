# Global Terraform
variable "environment" {
  description = "Architecture environment"
  type        = "string"
}

# Global DataDog
variable "message" {
  description = "Message sent when a Redis monitor is triggered"
}

variable "delay" {
  description = "Delay in seconds for the metric evaluation"
  default     = 600
}

variable "filter_tags_use_defaults" {
  description = "Use default filter tags convention"
  default     = "true"
}

variable "filter_tags_custom" {
  description = "Tags used for custom filtering when filter_tags_use_defaults is false"
  default     = "*"
}

# Azure API Management specific
variable "status_silenced" {
  description = "Groups to mute for API Management status monitor"
  type        = "map"
  default     = {}
}

variable "failed_requests_silenced" {
  description = "Groups to mute for API Management failed requests monitor"
  type        = "map"
  default     = {}
}

variable "failed_requests_threshold_critical" {
  description = "Maximum acceptable percent of failed requests"
  default     = 90
}

variable "failed_requests_threshold_warning" {
  description = "Warning regarding acceptable percent of failed requests"
  default     = 50
}

variable "other_requests_silenced" {
  description = "Groups to mute for API Management other requests monitor"
  type        = "map"
  default     = {}
}

variable "other_requests_threshold_critical" {
  description = "Maximum acceptable percent of other requests"
  default     = 90
}

variable "other_requests_threshold_warning" {
  description = "Warning regarding acceptable percent of other requests"
  default     = 50
}

variable "unauthorized_requests_silenced" {
  description = "Groups to mute for API Management unauthorized requests monitor"
  type        = "map"
  default     = {}
}

variable "unauthorized_requests_threshold_critical" {
  description = "Maximum acceptable percent of unauthorized requests"
  default     = 90
}

variable "unauthorized_requests_threshold_warning" {
  description = "Warning regarding acceptable percent of unauthorized requests"
  default     = 50
}

variable "successful_requests_silenced" {
  description = "Groups to mute for API Management successful requests monitor"
  type        = "map"
  default     = {}
}

variable "successful_requests_threshold_critical" {
  description = "Minimum acceptable percent of successful requests"
  default     = 10
}

variable "successful_requests_threshold_warning" {
  description = "Warning regarding acceptable percent of successful requests"
  default     = 30
}