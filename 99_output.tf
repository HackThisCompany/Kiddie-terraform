output "dc9_public_ip" {
    value = aws_instance.dc9.public_ip
}

output "dc9_private_ip" {
    value = aws_instance.dc9.private_ip
}

output "wintermute_straylight_private_ip" {
    value = aws_instance.wintermute_straylight.private_ip
}

output "ansibleinventory" {
    sensitive = true
    value = {
        all = {
            children = {
                dc9 = {
                    hosts = {
                        dc9 = {
                            ansible_host                 = aws_instance.dc9.public_ip
                            ansible_connection           = "ssh"
                            ansible_user                 = "ec2-user"
                            ansible_ssh_private_key_file = var.local_privkey_path
                            ansible_python_interpreter   = "python3"
                        }
                    }
                }
                wintermute_straylight = {
                    hosts = {
                        wintermute_straylight = {
                            ansible_host                 = aws_instance.wintermute_straylight.private_ip
                            ansible_connection           = "ssh"
                            ansible_user                 = "ec2-user"
                            ansible_ssh_private_key_file = var.local_privkey_path
                            ansible_ssh_common_args      = "-o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -W %h:%p -i ${var.local_privkey_path} -q ec2-user@${aws_instance.dc9.public_ip}\""
                            ansible_python_interpreter   = "python3"
                        }
                    }
                }
            }
        }
    }
}
