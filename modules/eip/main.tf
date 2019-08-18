data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_eip" "main" {
  vpc   = true
  count = "${var.az_count}"
  tags = {
    "Name"        = "eip-${var.name}-${data.aws_availability_zones.available.names[count.index]}"
    "Domain"      = "${var.namespace}"
    "Team"        = "${var.team}"
    "Environment" = "${var.environment}"
  }
}
