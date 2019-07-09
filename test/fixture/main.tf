provider "azurerm" {
  version         = "1.31.0"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = format("rg-%s", random_string.suffix.result)
  location = var.location
}

module "cache" {
  source          = "../../"
  rgid            = var.rgid
  environment     = var.environment
  location        = var.location
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  rg_name         = basename(azurerm_resource_group.rg.id)
  capacity        = 2
  family          = "C"
  sku_name        = "Standard"
}

