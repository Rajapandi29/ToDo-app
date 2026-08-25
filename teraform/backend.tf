terraform {
  backend "s3" {
    bucket = "my-terraformstate-18-8"
    key    = "my-terraformstate-18-8/Mug"
    region = "us-east-1"
    encrypt = true

  }
}
