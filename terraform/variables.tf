variable "linode_api_key" {
  type        = string
  description = "Linode API key."
}

variable "ssh_key" {
  type        = string
  description = "The new SSH key you generated with ssh-keygen."
}

variable "ssh_key_id" {
  type        = string
  description = "Existing SSH key already in Linode."
}

variable "region" {
  type        = string
  description = "The physical location of the resources."
  default     = "us-west"
}

variable "cloudflare_enabled" {
  type        = bool
  description = "Define if Cloudflare records should be created."
  default     = false
}

variable "cloudflare_email" {
  type        = string
  description = "Email Address used for Cloudflare account."
  default     = "test@test.com"
}

variable "cloudflare_api_key" {
  type        = string
  description = "Cloudflare API Key used to create DNS records."
  default     = "12345abc"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID to use for record creation."
  default     = ""
}

variable "strapi_srv_domain" {
  type        = string
  description = "Subdomain used for the Strapi Server."
  default     = "api"
}

variable "instance_os" {
  type        = string
  description = "The Operating system installed on the servers."
  default     = "linode/ubuntu20.04"
}

variable "instance_tag" {
  type        = string
  description = "Tag assigned to the instances."
  default     = "strapi"
}

variable "strapi_plan" {
  type        = string
  description = "The size of the Linode strapi instance"
  default     = "g6-standard-1"
}

variable "strapi_label" {
  type        = string
  description = "The label assigned to the strapi instance"
  default     = "my-strapi-srv"
}

variable "strapi_server_backups" {
  type        = bool
  description = "Enable auto backup on the database instance, warning this cost 2$ per month"
  default     = false
}

variable "database_plan" {
  type        = string
  description = "The size of the Linode database instance"
  default     = "g6-standard-2"
}

variable "database_label" {
  type        = string
  description = "The label assigned to the database instance"
  default     = "my-strapi-db"
}

variable "strapi_database_backups" {
  type        = bool
  description = "Enable auto backup on the database instance, warning this cost 2$ per month"
  default     = false
}
