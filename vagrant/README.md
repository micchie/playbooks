Example of preparing VM for NS3/DCE experiments
========================

# Prerequisite
* I assume you locate our entire ansible repository at ~/playbooks (so this file is at ~/playbooks/vagrant/README.md)

### Install Vagrant, Virtualbox and Ansible
* see https://www.vagrantup.com
* see https://www.virtualbox.org
* see http://www.ansible.com/home

### Download Debian VM template
* % vagrant box add debian80 https://downloads.sourceforge.net/project/vagrantboxjessie/debian80.box

# Create and launch a VM
#### Prepare and go to VM instance(s) directory
* We are creating a VM called ns3vm
* % mkdir -p ~/vagrant/ns3vm
* % cd ~/vagrant/ns3vm

#### Apply custom VM configuration

* Since NS3/DCE requires a large disk space, we create and attach an external 20GB disk to the launching VM. We also change the VM's NIC to use virtio.
* % cp ~/playbooks/vagrant/Vagrantfile.ns3vm ./Vagrantfile
* modify following two lines in Vagrantfile for your environment:
	* config.vm.provision :shell, path: "/Users/micchie/playbooks/vagrant/mount_ext_disk.sh"
	* ansible.playbook = "/Users/micchie/playbooks/vagrant_provision.yml"

#### Create and launch a VM

* (in the directory which you copied Vagrantfile to)
* % vagrant up
* Add the ssh_config entry of the new VM to your .ssh/config
	* % vagrant ssh-config >> ~/.ssh/config
* make sure that you can log in to the vm (ns3vm)
	* % ssh ns3vm

#### Provision with Ansible

* We first install necessary packages and ns3/dce. This takes about 1.5 hours. You will see what's going on from output.
* % ansible-playbook -i ~/playbooks/inventories/vagranthosts -l ns3hosts ~/playbooks/ns3mptcp.yml
