provider "aws" {
  region = "eu-west-2"
}

locals {
  domain = "testing.magnetar.it"
}

resource "aws_route53_zone" "magnetarit" {
  name = local.domain
}

module "ses" {
  source      = "../"
  r53_zone_id = aws_route53_zone.magnetarit.zone_id
  domain      = local.domain
}