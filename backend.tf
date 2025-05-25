terraform {
  backend "s3" {
    bucket         = "quibs-terraform-state"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-east-1"
    profile        = "quibs"
    dynamodb_table = "quibs-terraform-locks"
  }
}
