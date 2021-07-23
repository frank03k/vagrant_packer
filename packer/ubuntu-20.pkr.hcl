variable "ssh_username" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type    = string
  default = ""
}

locals {
  date = formatdate("YYYY-MM", timestamp())
}

source "qemu" "ubuntu" {
  iso_url          = "https://old-releases.ubuntu.com/releases/20.04.0/ubuntu-20.04-live-server-amd64.iso"
  iso_checksum     = "sha256:caf3fd69c77c439f162e2ba6040e9c320c4ff0d69aad1340a514319a9264df9f"
  output_directory = "output_ubuntu20_base"
  shutdown_command = "sudo systemctl poweroff"
  cpus             = 1
  memory           = 2048
  format           = "qcow2"
  accelerator      = "kvm"
  headless         = true
  http_directory   = "./http_subiquity"
  http_port_max    = 10089
  http_port_min    = 10082
  vnc_bind_address = "0.0.0.0"
  ssh_username     = "${var.ssh_username}"
  ssh_password     = "${var.ssh_password}"
  ssh_timeout      = "60m"
  vm_name          = "ubuntu20-${local.date}"
  net_device       = "virtio-net-pci"
  disk_interface   = "virtio"
  boot_wait        = "10s"
  vnc_port_min     = 5901
  vnc_port_max     = 5901
  boot_command = ["<esc><wait><esc><wait><f6><wait><esc><wait>",
    "<bs><bs><bs><bs><bs>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
  "--- <enter>"]
}

build {
  sources = ["source.qemu.ubuntu"]
}
