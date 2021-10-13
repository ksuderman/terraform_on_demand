variable "image" { default = "JS-API-Featured-Ubuntu20-Latest" }
variable "flavor" { default = "m1.xlarge" }
variable "key_pair" { default = "ks-cluster" }
variable "network" { default = "ks-network" }

variable "name" { default = "ks-github-terraform-bot"}

variable "s3_bucket" { }
variable "lock_table" {}

resource "openstack_compute_instance_v2" "node" {
  name            = var.name
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.fw.id, "default"]

  network {
    name = var.network
  }
}

resource "openstack_compute_floatingip_v2" "ip" {
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "node_ips" {
  floating_ip = openstack_compute_floatingip_v2.ip.address
  instance_id = openstack_compute_instance_v2.node.id
}

