resource "azurerm_subnet" "cncf" {
  name = "${ var.name }"
  resource_group_name = "${ var.name }"
  virtual_network_name = "${azurerm_virtual_network.cncf.name}"
  address_prefix = "10.0.10.0/24"
  route_table_id = "${ azurerm_route_table.cncf.id }"

}

/*
# gateway" "nat" {
  depends_on = [
    "aws_eip.nat",
    "aws_internet_gateway.main",
  ]

  allocation_id = "${ aws_eip.nat.id }"
  subnet_id = "${ aws_subnet.public.0.id }"
}

resource "aws_subnet" "private" {
  count = "${ length( split(",", var.azs) ) }"

  availability_zone = "${ element( split(",", var.azs), count.index ) }"
  cidr_block = "${ cidrsubnet(var.cidr, 8, count.index + 10) }"
  vpc_id = "${ aws_vpc.cncf.id }"

  tags {
    "kubernetes.io/role/internal-elb" = "${ var.name }"
    builtWith = "terraform"
    KubernetesCluster = "${ var.name }"
    kz8s = "${ var.name }"
    Name = "kz8s-${ var.name }-private"
    visibility = "private"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${ aws_vpc.cncf.id }"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${ aws_nat_gateway.nat.id }"
  }

  tags {
    builtWith = "terraform"
    KubernetesCluster = "${ var.name }"
    kz8s = "${ var.name }"
    Name = "kz8s-${ var.name }"
    visibility = "private"
  }
}

resource "aws_route_table_association" "private" {
  count = "${ length(split(",", var.azs)) }"

  route_table_id = "${ aws_route_table.private.id }"
  subnet_id = "${ element(aws_subnet.private.*.id, count.index) }"
}
*/
