terraform {
  required_version = "0.12.9"
}

provider "aws" {
  version = "2.30.0"
  region  = "ap-northeast-1"
  profile = "terraform-todo"
}

provider "aws" {
  version = "2.30.0"
  alias   = "virginia"
  region  = "us-east-1"
  profile = "terraform-todo"
}
