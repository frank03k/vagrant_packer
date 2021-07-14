source "qemu" "ubuntu" {
  iso_url          = "./iso/ubuntu-20.04.2-live-server-amd64.iso"
  iso_checksum     = "sha256:d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"
  output_directory = "output_ubuntu_base"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
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
  ssh_username     = "root"
  ssh_password     = "s3cr3t"
  ssh_timeout      = "20m"
  vm_name          = "ubuntu-base"
  net_device       = "virtio-net-pci"
  disk_interface   = "virtio"
  boot_wait        = "10s"
  boot_command     = ["<tab>"," linux ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu.ks", "<enter>"]
}

build {
  sources = ["source.qemu.ubuntu"]
}
