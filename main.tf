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

resource "aws_ses_domain_mail_from" "default" {
  domain           = aws_ses_domain_identity.default.domain
  mail_from_domain = aws_ses_domain_identity.default.domain
  depends_on       = [aws_ses_domain_dkim.default]
}

# Route53 MX record
resource "aws_route53_record" "ses_domain_mail_from_mx" {
  zone_id = var.r53_zone_id
  name    = aws_ses_domain_mail_from.default.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.eu-west-2.amazonses.com"]
}

# Route53 TXT record for SPF
resource "aws_route53_record" "ses_domain_mail_from_txt" {
  zone_id = var.r53_zone_id
  name    = aws_ses_domain_mail_from.default.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}