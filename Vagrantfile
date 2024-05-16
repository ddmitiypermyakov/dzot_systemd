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
 config.vm.define "systs" do |syst| 
 syst.vm.network "private_network", ip: "192.168.50.10",  virtualbox__intnet: "net1" 
 syst.vm.hostname = "systd" 
 syst.vm.provision "shell", path: "dz_1.sh", name: "dz1"
 syst.vm.provision "shell", path: "dz_2.sh", name: "dz2"
 syst.vm.provision "shell", path: "dz_3.sh", name: "dz3"
 end 

end