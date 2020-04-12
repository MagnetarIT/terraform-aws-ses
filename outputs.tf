output "ses_dkim_verification_fqdns" {
  value       = aws_route53_record.default_amazonses_dkim_record.*.fqdn
  description = "fqdns for the ses dkim records"
}

output "ses_verification_fqdn" {
  value       = aws_route53_record.default_amazonses_verification_record.fqdn
  description = "fqdn for the ses verification record"
}

output "ses_domain" {
  value       = aws_ses_domain_identity.default.domain
  description = "SES domain"
}
