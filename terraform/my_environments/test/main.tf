terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
    external = {
      source = "hashicorp/external"
      version = "2.2.3"
    }
  }
}
