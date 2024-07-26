locals {
  environment_vars = yamldecode(file("${path_relative_to_include()}/../../environment.yaml"))
  region_vars      = yamldecode(file("${path_relative_to_include()}/../region.yaml"))
  aws_account_id   = local.environment_vars["aws_account_id"]
  aws_role         = local.environment_vars["aws_role"]
  aws_region       = local.region_vars["aws_region"]
  aws_role_arn     = "arn:aws:iam::${local.aws_account_id}:role/${local.aws_role}"
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account_id}:role/${local.aws_role}"
  }
  region  = "${local.aws_region}"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "omi-prototyping-tfstate"
    key            = "infrastructure.${path_relative_to_include()}.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tf-lock"
    role_arn       = local.aws_role_arn
  }
}
