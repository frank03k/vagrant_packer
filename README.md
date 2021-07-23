---
title: "Packer - Demo project for learning"
author: "frank03k"
date: "23-07-2021"
---

# Packer - Demo project for learning

![Status](https://img.shields.io/badge/Status-DemoTutorial-orange) ![Packer Version](https://img.shields.io/badge/Packer-1.7.4-blue) ![Ansible Version](https://img.shields.io/badge/Ansible-2.11-green)

Tested the packer configuration on MacOS - ```vbox-ubuntu20.pkr.hcl```.
And run a vagrant vm for a testing on CentOS 8 within KVM (Qemu) provider.

In this repository i don't handle with preseed, subiquity or kickstart configuration. There are simple demo-configuration for the packer build.

- [Prerequisites](##Prerequisites)
- [Deployment](##Deployment)
    - [MacOS + Virtualbox](###MacOS+Virtualbox)
    - [Vagrant VM](###Vagrant-VM)

---

## Prerequisites

Following setup will be needed for this example repo:
* Ansible - [official install instruction](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* Virtualbox + Vagrant - [small instruction to install and use](https://www.taniarascia.com/what-are-vagrant-and-virtualbox-and-how-do-i-use-them/)
* if you want to use packer on your client, then packer - [official install instruction](https://www.packer.io/downloads)

## Deployment

### MacOS + Virtualbox

If you already a setup on MacOS with Virtualbox, you can use direct packer without a vagrant vm.

1. Change in packer directory

```bash
cd packer
```

2. Run the Deployment with following Arguments 

```bash
make FILE="vbox-ubuntu20.pkr.hcl" VARS="variables.pkrvars.hcl"
```

3. After the build is finished, you can use the image for further deployments or use cases.

### Vagrant VM

If you don't have a setup on you client, then we use a vagrant vm.

<div style="background-color:#eaeab5;color:black;height:50px;width;55%;border-radius:10px;text-indent:20px">
💡 Attention:

We need ansible for provisioning, so make sure you can use ansible with plain or with a virtualenv.
</div>
<br>

1. Start the vagrant vm

```bash
vagrant up
```

2. SSH-Connection

```bash
vagrant ssh
```

3. The vagrant vm has our packer directory mounted to /data, so we change to this directory and can run the packer build process.

```bash
cd /data
make FILE="ubuntu-20.pkr.hcl" VARS="variables.pkrvars.hcl"
```

4. After the build is finished, you can the image for further deployments or use cases.

