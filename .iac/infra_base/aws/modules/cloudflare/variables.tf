variable "zone_name" {
  description = "The name of the zone to create the record in."
  type        = string
}

variable "cname_name" {
  description = "The name of the record."
  type        = string
}

variable "cname_value_endpoint" {
  description = "The value of the record."
  type        = string
}

variable "cname_ttl" {
  description = "The TTL of the record."
  type        = number
  default     = 1
}

variable "cname_proxied" {
  description = "Whether the record is receiving the performance and security benefits of Cloudflare."
  type        = bool
  default     = true
}

variable "worker_script_name" {
  description = "The name of the worker script."
  type        = string
  default     = null
}

variable "worker_script_path" {
  description = "The worker script path."
  type        = string
  default     = null
}

variable "worker_script_root_dir" {
  description = "The root directory of the worker script."
  type        = string
  default     = null
}

variable "build_cicd" {
  description = "Whether to build the worker script in ci/cd."
  type        = bool
  default     = false
}
