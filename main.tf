resource "aws_ses_domain_identity" "default" {
  domain = var.domain
}

resource "aws_route53_record" "default_amazonses_verification_record" {
  zone_id = var.r53_zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "60"
  records = [aws_ses_domain_identity.default.verification_token]
}

resource "aws_ses_domain_dkim" "default" {
  domain     = aws_ses_domain_identity.default.domain
  depends_on = [aws_ses_domain_identity.default]
}

resource "aws_route53_record" "default_amazonses_dkim_record" {
  count   = 3
  zone_id = var.r53_zone_id
  name    = "${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}.dkim.amazonses.com"]
}