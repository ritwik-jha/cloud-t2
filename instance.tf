resource "aws_instance" "ins" {
    depends_on = [
        aws_security_group.sg,
    ]
    ami = "ami-09a7bbd08886aafdf"
    instance_type = "t2.micro"
    key_name = "mykey5"
    security_groups = ["${aws_security_group.sg.id}"]
    subnet_id = "subnet-52a09a3a"

    tags = {
        Name = "efs-instance"
    }
}


resource "null_resource" "mount" {
    depends_on = [
        aws_instance.ins,
        aws_efs_mount_target.mount,
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        port = 22
        private_key = file("C:/Users/ritwi/Downloads/mykey5.pem") 
        host = aws_instance.ins.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo su - root",
            "yum install -y httpd",
            "systemctl start httpd",
            "yum install -y amazon-efs-utils",
            "mount -t nfs4 ${aws_efs_mount_target.mount.ip_address}:/ /var/www/html/ ",
            "rm -rf /var/www/html/*",
            "git clone  https://github.com/ritwik-jha/instance_automation.git /var/www/html",
            "systemctl restart httpd"
        ]
    
    }
}