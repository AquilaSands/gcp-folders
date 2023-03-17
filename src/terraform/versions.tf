terraform {
  required_version = "~> 1.4"
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = "4.57.0"
    }
  }
}
