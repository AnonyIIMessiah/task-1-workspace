data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "eks_subnet" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# data "aws_subnet" "example" {
#   for_each = toset(data.aws_subnets.example.ids)
#   id       = each.value
# }

# output "subnet_cidr_blocks" {
#   value = [for s in data.aws_subnet.example : s.cidr_block]
# }


# resource "aws_subnet" "example" {
#   count = 3

#   availability_zone = data.aws_availability_zones.available.names[count.index]
#   cidr_block        = cidrsubnet(aws_vpc.example.cidr_block, 8, count.index)
#   vpc_id            = aws_vpc.example.id
# }

# resource "aws_vpc" "eks_vpc" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "eks_subnet" {
#   count                   = 3
#   vpc_id                  = aws_vpc.eks_vpc.id
#   cidr_block              = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   map_public_ip_on_launch = true
# }
