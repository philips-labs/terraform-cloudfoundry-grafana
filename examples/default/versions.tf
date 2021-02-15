terraform {

  required_providers {
    cloudfoundry = {
      source  = "philips-labs/cloudfoundry"
      version = ">= 0.1206.0"
    }
  }
  required_version = "~> 0.13"
}

