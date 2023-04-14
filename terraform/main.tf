# © 2020 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# This AWS Content is provided subject to the terms of the AWS Customer Agreement available at
# http://aws.amazon.com/agreement or other written agreement between Customer and either
# Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

#------------------------------------------------------------------------------
#
#  LZ global customizations
#
data "aws_caller_identity" "context" {}

# I first make sure that the account has the proper alternate contacts
resource "aws_account_alternate_contact" "billing" {
  alternate_contact_type = "BILLING"
  name                   = "Billing for AWS Account ${data.aws_caller_identity.current.account_id}"
  title                  = "Billing"
  email_address          = "ldawsbilling@example.com"
  phone_number           = "+34123456789"
}

resource "aws_account_alternate_contact" "security" {
  alternate_contact_type = "SECURITY"
  name                   = "Security for AWS Account ${data.aws_caller_identity.current.account_id}"
  title                  = "Security"
  email_address          = "ldawssecurity@example.com"
  phone_number           = "+34123456789"

  depends_on = [
    aws_account_alternate_contact.billing
  ]
}

resource "aws_account_alternate_contact" "operations" {
  alternate_contact_type = "OPERATIONS"
  name                   = "Operations for AWS Account ${data.aws_caller_identity.current.account_id}"
  title                  = "Operations"
  email_address          = "ldawsoperations@example.com"
  phone_number           = "+34123456789"

  depends_on = [
    aws_account_alternate_contact.security
  ]
}

#
# No public S3 bucket allowed
resource "aws_s3_account_public_access_block" "global_block" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
