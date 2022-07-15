variable "REGION" {
  default = "us-east-1"
}
variable "ZONE1" {
  default = "us-east-1a"
}
variable "ZONE2" {
  default = "us-east-1b"
}
variable "ZONE3" {
  default = "us-east-1c"
}
variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0cff7528ff583bf9a"
    us-east-2 = "ami-03e57de632660544c"
  }
}
variable "USER" {
  default = "ec2-user"
}
variable "PUB-KEY" {
  default = "Emc.pub"
}
variable "PRIV-KEY" {
  default = "Emc"
}
