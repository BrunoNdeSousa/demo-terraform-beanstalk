resource "aws_security_group_rule" "example" {
  description       = "Allow connectivity on port 80"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "sg-07ba1557dba819a05"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}