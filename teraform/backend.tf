terraform {
  backend "s3" {
    bucket  = "my-terraformstate-18-8"
    key     = "my-terraformstate-18-8/mug1"
    region  = "us-east-1"
    encrypt = true

  }
}
