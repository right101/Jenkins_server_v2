variable "key_name" {
  description = "SSH key"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "instance_name" {
  description = "Instance name"
  type        = string
}

variable "akumo-network" {
  description = "AkumoNetwork"
  type        = list(string)
}


variable "ami" {
  default = "ami-024e6efaf93d85776"
}

variable "root_volume_size" {
}

variable "jenkins_a_record" {
}


variable "home-network" {

}

variable "https_cidr" {
  type = list(string)
}