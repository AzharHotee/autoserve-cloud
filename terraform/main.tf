resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr1234" # must be globally unique & only letters/numbers
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

#resource "azurerm_service_plan" "plan" {
#  name                = "${var.prefix}-asp"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  os_type             = "Linux"
#  sku_name            = "F1"
#}

#resource "azurerm_linux_web_app" "app" {
#  name                = "${var.prefix}-webapp"
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  service_plan_id     = azurerm_service_plan.plan.id

#  https_only = true

#  site_config {
#    application_stack {
#      docker_image_name   = "${azurerm_container_registry.acr.login_server}/${var.prefix}-api:${var.docker_image_tag}"
#      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
#    }

#    always_on        = true
#  }

#  app_settings = {
#    "WEBSITES_PORT"               = "8000"
#  }

#  identity {
#    type = "SystemAssigned"
#  }
#}

