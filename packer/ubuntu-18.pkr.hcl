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
  # ubuntu 18.04
  iso_url          = "https://old-releases.ubuntu.com/releases/bionic/ubuntu-18.04-server-amd64.iso"
  iso_checksum     = "sha256:a7f5c7b0cdd0e9560d78f1e47660e066353bb8a79eb78d1fc3f4ea62a07e6cbc"
  output_directory = "output_ubuntu18_base"
  shutdown_command = "sudo systemctl poweroff"
  disk_size        = "5000M"
  cpus             = 1
  memory           = 2048
  format           = "qcow2"
  accelerator      = "kvm"
  headless         = true
  http_directory   = "http"
  http_port_max    = 10089
  http_port_min    = 10082
  vnc_bind_address = "0.0.0.0"
  ssh_username     = "${var.ssh_username}"
  ssh_password     = "${var.ssh_password}"
  ssh_timeout      = "60m"
  vm_name          = "ubuntu18-${local.date}"
  net_device       = "virtio-net-pci"
  disk_interface   = "virtio"
  boot_wait        = "10s"
  vnc_port_min     = 5901
  vnc_port_max     = 5901
  boot_command = ["<esc><wait>", "<esc><wait>", "<enter><wait>",
    "/install/vmlinuz<wait>", " initrd=/install/initrd.gz",
    " auto-install/enable=true", " debconf/priority=critical",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>",
  " -- <wait>", "<enter><wait>"]
}

build {
  sources = ["source.qemu.ubuntu"]
}
