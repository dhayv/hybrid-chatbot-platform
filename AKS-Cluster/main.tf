provider "azurerm" {
  features {}
}


module "aks" {
  source  = "Azure/aks/azurerm"
  version = "10.2.0"
  # insert the 2 required variables here
  resource_group_name = "chatbotcluster-rg"
  prefix              = "chatbot"
  location            = "East US 2"
  cluster_name        = "chatbotcluster"
  agents_min_count    = 2
  agents_max_count    = 3
  agents_count        = 2
  agents_pool_name    = "chatbotpool"
  kubernetes_version  = "1.33.0"
  oidc_issuer_enabled = true

  # optionally, you can specify other variables here  
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}



