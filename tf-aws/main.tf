terraform {
  cloud {
    organization = "terraform-adv-training"

    workspaces {
      name = "tf-adv-training-workspace"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "web1" {
  ami           = "ami-0127b2e6f3b9b94d5"
  instance_type = "t1.micro"

  tags = {
    Name = var.instance_name
  }
}
