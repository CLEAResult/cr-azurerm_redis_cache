# cr-azurerm_redis_cache

Creates an Azure Redis Cache instance.

This module requires Terraform 0.12.x+.

# Testing

To test this module with terratest:

1. Add a valid Azure subscription and tenant ID to the `test/fixture/test.tfvars` file
2. Run `cd test && go test`
