terraform {
  backend "s3" {
    bucket         = "pedrin-clabs-tfmodule-kk1"
    key            = "clusters/cloud-labs/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pedrin-clterraform-locks"
    encrypt        = true
  }
}
