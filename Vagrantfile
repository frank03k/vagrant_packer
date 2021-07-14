# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "generic/centos8"
NODE_COUNT = 1

Vagrant.configure("2") do |config|
  (1..NODE_COUNT).each do |counter|
    config.vm.synced_folder "./packer", "/data"
    config.vm.define "packer-#{counter}" do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "packer-#{counter}"
      config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 4
        v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
    end
    end
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision.yml"
    end
  end
end