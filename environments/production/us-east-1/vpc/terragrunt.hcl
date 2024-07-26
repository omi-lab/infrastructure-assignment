include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws//.?version=5.9.0"
}

locals {
  environment_vars = yamldecode(file("../../environment.yaml"))
  region_vars      = yamldecode(file("../region.yaml"))
  environment      = local.environment_vars["environment"]
  vpc_cidr         = local.region_vars["vpc_cidr"]
  vpc_azs          = local.region_vars["vpc_azs"]
}

inputs = {
  name = "eks-${local.environment}"

  cidr = local.vpc_cidr

  azs             = local.vpc_azs
  private_subnets = [cidrsubnet(local.vpc_cidr, 3, 0), cidrsubnet(local.vpc_cidr, 3, 1), cidrsubnet(local.vpc_cidr, 3, 2)]
  public_subnets  = [cidrsubnet(local.vpc_cidr, 3, 3), cidrsubnet(local.vpc_cidr, 3, 4), cidrsubnet(local.vpc_cidr, 3, 5)]

  enable_nat_gateway = true
  enable_vpn_gateway = false
}
