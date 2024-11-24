
resource "aws_security_group" "eks_worker_sg" {
  name        = "eks-worker-sg"
  description = "Security group for EKS worker node"
  vpc_id      = aws_vpc.vpc.id # Replace with your VPC ID

  # Outbound Rules: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-worker-sg"
  }
}

# Inbound Rules for Worker Node Security Group
resource "aws_security_group_rule" "worker_inbound_k8s_api" {
  security_group_id = aws_security_group.eks_worker_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_worker_sg.id 
}

resource "aws_security_group_rule" "worker_inbound_node_to_node" {
  security_group_id = aws_security_group.eks_worker_sg.id
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_worker_sg.id
}

resource "aws_security_group_rule" "worker_inbound_nodeport" {
  security_group_id = aws_security_group.eks_worker_sg.id
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] 
}

resource "aws_security_group_rule" "worker_inbound_dns" {
  security_group_id = aws_security_group.eks_worker_sg.id
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  source_security_group_id = aws_security_group.eks_worker_sg.id
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.eks_worker_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_worker_sg.id
}
