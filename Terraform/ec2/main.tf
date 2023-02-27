# basion host 
resource "aws_instance" "public-ec2" {
  ami                         = var.ami
  instance_type               = var.ec2_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.enable_publicIP
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name

  tags = {
    Name = var.ec2_name
  }
}


