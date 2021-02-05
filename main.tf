provider "azurerm" {
  version = "=2.0.0"
  features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tstate"
        storage_account_name = "sktkcsaccount"
        container_name       = "terraform.tfstate"
    }     
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resourcegroup" {
  name = "terraform-appservices"
  location = "eastus"
}

resource "azurerm_app_service_plan" "serviceplan" {
  name                = "terraform-sp"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  sku {
    tier = "Standard"
    size = "S1"
  
  }
}

resource "azurerm_app_service" "appservice" {
  name = "terraform-kcs"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  app_service_plan_id = azurerm_app_service_plan.serviceplan.id
  
  site_config {
    linux_fx_version = "DOTNETCORE|2.2"
    min_tls_version = "1.2"
    always_on = true
    scm_type = "None"
    managed_pipeline_mode = "Integrated"
    websockets_enabled = false
    use_32_bit_worker_process = true
  }
}
