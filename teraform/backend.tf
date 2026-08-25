terraform {
  backend "s3" {
    bucket = "my-terraformstate-18-8"
    key    = "Buckets/my-terraformstate-18-8/mug"
    region = "us-east-1"
    encrypt = true

  }
}
