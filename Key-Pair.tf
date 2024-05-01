resource "tls_private_key" "tfkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tfkey" {
  depends_on = [tls_private_key.tfkey]
  key_name   = "tfkey" # Create a "tfkey" to AWS!!
  public_key = tls_private_key.tfkey.public_key_openssh

}

resource "null_resource" "pem_file" {
  depends_on = [aws_key_pair.tfkey]
  provisioner "local-exec" { # Create a "tfkey.pem" to your computer!!
    command = "echo '${tls_private_key.tfkey.private_key_pem}' > ./tfkey.pem"
  }
}

resource "null_resource" "change_pem_permissions" {
  depends_on = [null_resource.pem_file]
  provisioner "local-exec" { #Changin the pem file permission as 400!!
    command = "chmod 400 ./tfkey.pem"
  }
}