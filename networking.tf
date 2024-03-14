# CREATING VPC AND PRIVATE SUBNETS 

resource "aws_vpc" "tfvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "tfvpc"
  }
}

resource "aws_subnet" "tfsubnet1" {
    vpc_id = aws_vpc.tfvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
    Name = "tf-subnet-1"
  }
}

resource "aws_subnet" "tfsubnet2" {
    vpc_id = aws_vpc.tfvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
    tags = {
    Name = "tf-subnet-2"
  }
}

# CREATING INTERNET GATEWAY, ROUTE TABLE AND ASSOCIATION

resource "aws_internet_gateway" "tfigw" {
    vpc_id = aws_vpc.tfvpc.id
    tags = {
    Name = "tf-internet-gateway"
  }
}

resource "aws_route_table" "tfrt" {
    vpc_id = aws_vpc.tfvpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tfigw.id
    }
    tags = {
    Name = "tf-route-table"
  }
}
resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.tfsubnet1.id
  route_table_id = aws_route_table.tfrt.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.tfsubnet2.id
  route_table_id = aws_route_table.tfrt.id
}


# CREATE APPLICATION LOAD BALANCER and TARGET GROUP

resource "aws_lb" "tflb" {
  name = "tf-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.tfsg.id]
  subnets = [aws_subnet.tfsubnet1.id, aws_subnet.tfsubnet2.id]
  tags = {
    Name = "Terraform ALB"
  }
}
resource "aws_lb_target_group" "tftg" {
  name = "tftg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.tfvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# ASSOCIATION OF INSTACES WITH THE TARGET GROUP AND TG ATTACH WITH LB

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tftg.arn
  target_id = aws_instance.webserver1.id
  port = 80
}
resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tftg.arn
  target_id = aws_instance.webserver2.id
  port = 80
}

resource "aws_lb_listener" "tflistener" {
  load_balancer_arn = aws_lb.tflb.arn
  port = 80
  protocol = "HTTP"

  default_action {
   target_group_arn = aws_lb_target_group.tftg.arn
   type = "forward"
  }
}