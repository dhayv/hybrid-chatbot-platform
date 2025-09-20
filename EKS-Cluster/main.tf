provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "aws-demo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway      = true
  enable_vpn_gateway      = false
  single_nat_gateway      = true
  map_public_ip_on_launch = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }


}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.1"

  name               = "aws-eks-cluster"
  kubernetes_version = "1.33"

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }


  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = false

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    on_demand = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }

  access_entries = {
    admin = {
      principal_arn = var.admin
      policy_associations = {
        admin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster", namespaces = [] }
        }
      }
    }
    co-admin = {
      principal_arn = var.admin2
      policy_associations = {
        admin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster", namespaces = [] }
        }
      }
    }
  }


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

output "cluster_sg_id" { value = module.eks.cluster_security_group_id }
output "node_sg_id" { value = module.eks.node_security_group_id }
output "eks_cluster" { value = module.eks.cluster_name }
output "nat_gateway_public_ip" {
  value = module.vpc.nat_public_ips[0]
  description = "Public IP of the NAT Gateway"
}