resource "yandex_vpc_security_group" "group1" {
  name        = "My security group"
  network_id  = yandex_vpc_subnet.subnet_1.id

  labels = {
    my-label = "my-label-value"
  }

  ingress {
    protocol       = "TCP"
    description    = "rule1 description"
    v4_cidr_blocks = ["10.10.1.0/24", "10.10.2.0/24"]
    port           = 8080
  }

  egress {
    protocol       = "ANY"
    description    = "rule2 description"
    v4_cidr_blocks = ["10.10.1.0/24", "10.10.2.0/24"]
    from_port      = 8090
    to_port        = 8099
  }

  egress {
    protocol       = "UDP"
    description    = "rule3 description"
    v4_cidr_blocks = ["10.10.1.0/24"]
    from_port      = 8090
    to_port        = 8099
  }
}