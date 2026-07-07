data "aws_vpc" "this" {
  tags = {
    Name = "cloud-labs-vpc"
  }
}

data "aws_security_group" "pivpn" {
  tags = {
    Application = "pivpn"
  }
}

data "aws_ecrpublic_authorization_token" "token" {
  region = "us-east-1"
}


data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  tags = {
    Tier = "Private"
  }
}

