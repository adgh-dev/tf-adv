vterraform {
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

module "iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.11.2"
  name="my_user_created_from_module1"


}
output user_arn {
  value = module.iam-user.iam_user_arn
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = module.iam-user.iam_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}
