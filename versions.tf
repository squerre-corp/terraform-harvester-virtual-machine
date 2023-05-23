terraform {
  required_version = ">= 1.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6"
    }
  }
}
