# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure(2) do |config| 
 #config.vm.box = "centos8s" 
  config.vm.box = "centos8s" 
 #config.vm.box_version = "2004.01" 
 config.vm.synced_folder "sync/", "/vagrant", type: "rsync", create: "true"
 config.vm.provider "virtualbox" do |v| 
 v.memory = 256 
 v.cpus = 1 
 end 
 config.vm.define "nfss" do |syst| 
 syst.vm.network "private_network", ip: "192.168.50.10",  virtualbox__intnet: "net1" 
 syst.vm.hostname = "systd" 
 #box.vm.provision "shell", path: "nfs_server.sh", name: "nfss"
 end 

end