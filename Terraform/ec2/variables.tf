variable "ami" {
  type        = string
  description = "ami for ec2"
}

variable "ec2_type" {
  type        = string
  description = "instance type"
}

variable "subnet_id" {
  type        = string
  description = "id for basion host subnet"
}

variable "sg_id" {
  type        = string
  description = "id for security group"
}

variable "key_name" {
  type        = string
  description = "name of key"
}

variable "ec2_name" {
  type        = string
  description = "name of ec2"
}

variable "vpcID" {
  type        = string
  description = "vpc id"
}

variable "enable_publicIP" {
  type        = bool
  description = "true"
}