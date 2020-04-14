<a href=https://magnetarconsulting.co.uk><img src="https://magnetarconsulting.co.uk/wp-content/uploads/2020/04/small-helping-you-innovate-magnetar.png" width="300"></a>


# terraform-aws-ses
Terraform (>= 0.12.0) module to create SES email domain and verify using r53

[![Build Status](https://dev.azure.com/MagnetarIT/terraform-aws-ses/_apis/build/status/MagnetarIT.terraform-aws-ses?branchName=master)](https://dev.azure.com/MagnetarIT/terraform-aws-ses/_build/latest?definitionId=14&branchName=master) ![Latest Release](https://img.shields.io/github/release/MagnetarIT/terraform-aws-ses.svg)


- [Intro](#Intro)
- [Example](#Example)
- [Inputs](#Inputs)
- [Outputs](#Outputs)
- [Support](#Support)
- [License](#License)

----

## Example
```hcl

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
  source      = "git::https://github.com/MagnetarIT/terraform-aws-ses.git?ref=tags/0.1.0"
  r53_zone_id = aws_route53_zone.magnetarit.zone_id
  domain      = local.domain
}

```

----

## Intro
This module will create the following resources
- SES domain
- SES DKIM
- r53 verification records for SES

---

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | The domain name to assign to SES | `string` | n/a | yes |
| r53\_zone\_id | The zone id where to create domain verification records | `string` | n/a | yes |

---

## Outputs

| Name | Description |
|------|-------------|
| ses\_dkim\_verification\_fqdns | fqdns for the ses dkim records |
| ses\_domain | SES domain |
| ses\_verification\_fqdn | fqdn for the ses verification record |

## Support

Reach out to me at one of the following places!

- Website at <a href="https://magnetarconsulting.co.uk" target="_blank">`magnetarconsulting.co.uk`</a>
- Twitter at <a href="https://twitter.com/magnetarIT" target="_blank">`@magnetarIT`</a>
- LinkedIn at <a href="https://www.linkedin.com/company/magnetar-it-consulting" target="_blank">`magnetar-it-consulting`</a>

---

## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
