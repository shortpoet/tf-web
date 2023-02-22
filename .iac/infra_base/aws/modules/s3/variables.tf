variable "site_domain_bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "redirect_all_requests_to" {
  description = "The website endpoint to which all requests are redirected"
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the bucket."
  default     = {}
}
