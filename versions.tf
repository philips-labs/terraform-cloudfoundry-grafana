terraform {
  required_version = ">= 1.1.0"

  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = ">= 0.50.1"
    }
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.38.15"
    }
  }
}
