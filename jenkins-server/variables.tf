variable "ports" {
  type = list(string)
  description = "list of ports"
}

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

variable "network" {
  description = "network"
  type        = list(string)
}


variable "ami" {

}

variable "root_volume_size" {
}

variable "jenkins_a_record" {
}

variable "https_cidr" {

}

