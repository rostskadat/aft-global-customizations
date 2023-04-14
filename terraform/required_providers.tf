terraform {
  required_providers {
    aws = {
      version               = "~> 3.70.0"
      source                = "hashicorp/aws"
      configuration_aliases = [aws.us_east_1, aws.mgt_eu_west_1]
    }
  }
}