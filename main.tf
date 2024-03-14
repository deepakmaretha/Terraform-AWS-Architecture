resource "aws_instance" "webserver1" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = [aws_security_group.tfsg.id]
  subnet_id = aws_subnet.tfsubnet1.id
  user_data = base64encode(file(var.userdata))
  key_name = aws_key_pair.tfkey.key_name
  tags = {
    Name = "TF-WEB-SERVER-1"
  }
}

resource "aws_instance" "webserver2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = [aws_security_group.tfsg.id]
  subnet_id = aws_subnet.tfsubnet2.id
  user_data = base64encode(file(var.userdata2))
  key_name = aws_key_pair.tfkey.key_name
  tags = {
    Name = "TF-WEB-SERVER-2"
  }
}