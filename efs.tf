resource "aws_efs_file_system" "t2efs" {
    creation_token = "task2-efs"

    tags = {
        Name = "my-task2-vpc"
    }
}

resource "aws_efs_mount_target" "mount" {
    depends_on = [
        aws_efs_file_system.t2efs,
        aws_security_group.sg,
        ]
    subnet_id = "subnet-52a09a3a"
    file_system_id = aws_efs_file_system.t2efs.id
    security_groups = ["${aws_security_group.sg.id}"]
}