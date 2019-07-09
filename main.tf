resource "azurerm_redis_cache" "primary" {
  name                = format("%s%03d", local.name, count.index + 1)
  count               = var.num
  resource_group_name = var.rg_name
  location            = var.location
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {}
  tags = {
    InfrastructureAsCode = "True"
  }
}

resource "azurerm_redis_firewall_rule" "primary" {
  name                = format("%s%03d", local.name, count.index + 1)
  count               = var.num
  redis_cache_name    = azurerm_redis_cache.primary[count.index].name
  resource_group_name = var.rg_name
  start_ip            = var.redis_fw_start_ip
  end_ip              = var.redis_fw_end_ip
}

resource "azuread_group" "RedisCacheContributor" {
  name = format("g%s%s%s_AZ_RedisCacheContributor", local.default_rgid, local.env_id, local.rg_type)
}

data "azurerm_subscription" "primary" {}

resource "azurerm_role_assignment" "RedisCacheContributor" {
  scope                = format("%s/resourceGroups/%s", data.azurerm_subscription.primary.id, var.rg_name)
  role_definition_name = "Redis Cache Contributor"
  principal_id         = azuread_group.RedisCacheContributor.id
}

