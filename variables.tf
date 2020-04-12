variable "domain" {
  type        = string
  description = "The domain name to assign to SES"
}

variable "r53_zone_id" {
  type        = string
  description = "The zone id where to create domain verification records"
}
