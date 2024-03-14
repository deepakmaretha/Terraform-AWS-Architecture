
output "load_balancer_dns" {
  value = aws_lb.tflb.dns_name
}

output "webserver-1-IP" {
  value = aws_instance.webserver1.public_ip
}

output "webserver-2-IP" {
  value = aws_instance.webserver2.public_ip
}

output "attached-key" {
  value = "tfkey.pem"
}

output "Server-Access-URL" {
  value = "http://${aws_lb.tflb.dns_name}"
}
