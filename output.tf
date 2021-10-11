locals {
    key = var.key_pair
    ip = openstack_compute_floatingip_v2.ip.address
}

resource "local_file" "ipfile" {
    content = templatefile("./templates/cluster.tpl", { ip=local.ip, key=local.key})
    filename = "./comment.txt"
}

