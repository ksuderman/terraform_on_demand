locals {
    key = pathexpand("~/.ssh/${var.key_pair}.pem")
    ip = openstack_compute_floatingip_v2.ip.address
}

# output "ip_addresses" {
#     count = var.num_nodes
#     value = "${openstack_compute_instance_v2.nodes[count.index].name} = ${openstack_compute_floatingip_v2.floating_ips[count.index].address}"
# } 

resource "local_file" "ipfile" {
    content = templatefile("./templates/cluster.tpl", { ip=local.ip, key=local.key})
    filename = pathexpand("~/.cluster/ghjobs")
}

# resource "local_file" "inventories" {
#     count = var.num_nodes
#     content = templatefile("./templates/inventory.tpl", { ip=local.ips[count.index].address, key=local.key, name=local.nodes[count.index].name})
#     filename = pathexpand("~/.inventories/bench${count.index+1}.ini")
#     #filename = "/tmp/bench${count.index+1}.ini"
# }
