variable "projectName" {
  default = "mechanical-hub"
}

variable "region_default" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "aws_account_id" {
  description = "ID da conta AWS Academy (muda a cada bimestre da pos-graduacao)"
  type        = string
}

variable "tags" {
  default = {
    School      = "FIAP"
    Environment = "Production"
  }
}

locals {
  labRole      = "arn:aws:iam::${var.aws_account_id}:role/LabRole"
  principalArn = "arn:aws:iam::${var.aws_account_id}:role/voclabs"
}
