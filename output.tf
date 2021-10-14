locals {
    key = var.key_pair
    ip = aws_eip.frontend.public_ip
}

resource "local_file" "ipfile" {
    content = templatefile("./templates/cluster.tpl", { ip=local.ip, key=local.key})
    filename = "./comment.txt"
}

