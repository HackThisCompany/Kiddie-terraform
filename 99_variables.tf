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

variable local_privkey_path {
  type        = string
  default     = "~/.ssh/kiddie.id_rsa"
  description = "Kiddie PubKey Name for Management"
}


variable dc9_instance_type {
  type = string
  # 2vcpu + 2G ==> 0.0204 $ , 67% disc.
  default     = "t3a.small"
  description = "DC-9 instance type"
}

variable dc9_spot_price {
  type = string
  # Spot price = 0.0204 * (1- 0.67) = 0.006732
  default     = "0.01"
  description = "DC-9 spot instance price threshold"
}

variable wintermute_straylight_instance_type {
  type = string
  # 2vcpu + 2G ==> 0.0204 $ , 67% disc.
  default     = "t3a.small" # NOTE: Needs IPv6 support
  description = "Wintermute Straylight instance type"
}

variable wintermute_straylight_spot_price {
  type = string
  # Spot price = 0.0204 * (1- 0.67) = 0.006732
  default     = "0.01"
  description = "Wintermute Straylight spot instance price threshold"
}
