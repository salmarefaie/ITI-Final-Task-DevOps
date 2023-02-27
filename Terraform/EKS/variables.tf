variable "cluster-name" {
  type        = string
  description = "name of cluster"
}

variable "cluster-role-arn" {
  type        = string
  description = "arn of cluster role"
}

variable "public-subnet1-id" {
  type        = string
  description = "id of public subnet 1"
}

variable "public-subnet2-id" {
  type        = string
  description = "id of public subnet 2"
}

variable "private-subnet1-id" {
  type        = string
  description = "id of private subnet 1"
}

variable "private-subnet2-id" {
  type        = string
  description = "id of private subnet 2"
}

variable "policy-cluster" {
  type        = any
  description = "policy of eks cluster"
}

variable "worker-nodes-name" {
  type        = string
  description = "name of worker node"
}

variable "node-role-arn" {
  type        = string
  description = "arn of node role"
}

variable "policy-container-readonly" {
  type        = any
  description = "policy of container read only"
}

variable "policy-CNI" {
  type        = any
  description = "policy of cni"
}

variable "policy-node" {
  type        = any
  description = "policy of node"
}

variable "endpoint" {
  type        = bool
  description = "true"
}

variable "instance_type" {
  type        = string
  description = "type of instance for node worker"
}

variable "key" {
  type        = string
  description = "key"
}

variable "capacity_type" {
  type        = string
  description = "type of capacity for node worker"
}