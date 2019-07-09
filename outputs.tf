output "id" {
  value = azurerm_redis_cache.primary.*.id
}

output "hostname" {
  value = azurerm_redis_cache.primary.*.hostname
}

output "port" {
  value = azurerm_redis_cache.primary.*.port
}

output "ssl_port" {
  value = azurerm_redis_cache.primary.*.ssl_port
}

output "primary_access_key" {
  value = azurerm_redis_cache.primary.*.primary_access_key
}

output "connection_string" {
  value = format("%s@%s?ssl=true", azurerm_redis_cache.primary.*.primary_access_key, azurerm_redis_cache.primary.*.hostname)
}

output "azurerm_redis_firewall_rule" {
  value = azurerm_redis_firewall_rule.primary.*.id
}

