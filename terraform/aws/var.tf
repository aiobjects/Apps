variable "region" {
  default = "ap-south-1"
}
variable "AMIS" {
  type = map
  default = {
    ap-south-1 = "ami-006d3995d3a6b963b"
  }
}
variable "type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
  sensitive   = true
}
variable "tags" {
  type = object({
    name = string
  })
  description = "Tags for the EC2 instance"
  default = {
    name = "Test Machine"
  }
}