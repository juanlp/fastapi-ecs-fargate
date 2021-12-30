locals {
  az_suffix = ["a", "b", "c", "d", "e", "f"]

  availability_zones = { for i in range(var.az_count) : element(local.az_suffix, i) => format("%s%s", var.aws_region, element(local.az_suffix, i)) }
}