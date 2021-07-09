terraform {

  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = ">= 0.14.1"
    }
    hsdp = {
      source = "philips-software/hsdp"
    }
  }
  required_version = ">= 0.14"
}

