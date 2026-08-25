terraform {
  backend "s3" {
    bucket = "terraform-state-25-8"
    key    = "terraform-state-25-8/Buckets"
    region = "us-east-1"
    encrypt = true

  }
}
