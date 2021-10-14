locals {
    args = {
        key = var.key_name
        ip = aws_eip.frontend.public_ip
        id = aws_instance.vm1.id
    }
}

resource "local_file" "ipfile" {
    # content = templatefile("./templates/cluster.tpl", { ip=local.ip, key=local.key})
    content = templatefile("./templates/cluster.tpl", local.args)
    filename = "./comment.txt"
}

