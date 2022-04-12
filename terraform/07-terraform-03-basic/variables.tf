variable "instances" {
  description = "Map of project names to configuration."
  type        = map
  default     = {
    node_1 = {
      instance_type           = "t2.micro",
      name                    = "node_1"
    },
    node_2 = {
      instance_type           = "t2.nano",
      name                    = "node_2"
    }
  }
}
