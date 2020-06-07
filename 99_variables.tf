variable region {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable tags {
  type        = map
  description = "Default tags"
}

variable vpc_cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR for Kiddie VPC"
}

variable public_subnet_cidr_block {
  type        = string
  default     = "10.0.0.0/24"
  description = "CIDR for Public Subnet"
}

variable private_subnet_cidr_block {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR for Private Subnet"
}

variable key_name {
  type        = string
  default     = "kiddie"
  description = "Kiddie PubKey Name for Management"
}
