#!/bin/bash
apt udpate -y
apt install -y apache2

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title> TEST WEBSITE </title>
    <h1> TEST WEBSITE USING TERRAFORM FROM WEBSERVER 2</h1>
</head>
</html>
EOF


systemctl start apache2
systemctl enable apache2
