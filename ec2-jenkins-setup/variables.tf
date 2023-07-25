# Set the desired aws region
variable "AWS_REGION" {
  default = "us-east-1"
}

# The AMI id (here: Amazon Linux 2023 64-bit Image)
variable "AMI" {
  default = "ami-05548f9cecf47b442"
}

# The desired instance type (here: t2.medium 2vCPU, 4GiB Mem)
variable "INSTANCE_TYPE" {
  default = "t2.medium"
}

# Key Pair name for the EC2
variable "AWS_KEY_PAIR" {
  default = "dom-jenkins-mc"
}

# The Jenkins artifact bucket name
variable "BUCKET_NAME" {
  default = "mc-jenkins-artifacts-s3"
}
