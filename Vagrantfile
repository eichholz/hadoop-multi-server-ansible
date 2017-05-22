# -*- mode: ruby -*-
# vi: set ft=ruby :

#http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/ClusterSetup.html

PRIVATE_KEY_SOURCE      = '~/.vagrant.d/insecure_private_key'
PRIVATE_KEY_DESTINATION = '/home/vagrant/.ssh/id_rsa'
MASTER_IP               = '192.168.51.4'
DATA1_IP                = '192.168.51.5'
DATA2_IP                = '192.168.51.6'

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  # define Master server
  config.vm.define "master" do |master|
    master.vm.hostname = "hadoop-master"
    master.vm.box = "phusion/ubuntu-14.04-amd64"
    master.vm.synced_folder ".", "/home/vagrant/src", mount_options: ["dmode=775,fmode=664"]
    master.vm.network "private_network", ip: MASTER_IP
    master.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.cpus = 2
      v.memory = 3072
    end
    master.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      v.vmx["displayName"] = "hadoop-master"
      v.vmx["ethernet1.pcislotnumber"] = "36"
    end
    # copy private key so hosts can ssh using key authentication (the script below sets permissions to 600)
    master.vm.provision :file do |file|
      file.source      = PRIVATE_KEY_SOURCE
      file.destination = PRIVATE_KEY_DESTINATION
    end
    master.vm.provision "shell", path: "bootstrap-master.sh"
  end

  # define data1 server
  config.vm.define "data1" do |data1|
    data1.vm.hostname = "hadoop-data1"
    data1.vm.box = "phusion/ubuntu-14.04-amd64"
    data1.vm.network "private_network", ip: DATA1_IP
    data1.vm.provider "virtualbox" do |v|
      v.name = "data1"
      v.cpus = 2
      v.memory = 3072
    end
    data1.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      v.vmx["displayName"] = "hadoop-data1"
      v.vmx["ethernet1.pcislotnumber"] = "36"
    end
    # copy private key so hosts can ssh using key authentication (the script below sets permissions to 600)
    data1.vm.provision :file do |file|
      file.source      = PRIVATE_KEY_SOURCE
      file.destination = PRIVATE_KEY_DESTINATION
    end
  end

  # define data2 server
  config.vm.define "data2" do |data2|
    data2.vm.hostname = "hadoop-data2"
    data2.vm.box = "phusion/ubuntu-14.04-amd64"
    data2.vm.network "private_network", ip: DATA2_IP
    data2.vm.provider "virtualbox" do |v|
      v.name = "data2"
      v.cpus = 2
      v.memory = 3072
    end
    data2.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      v.vmx["displayName"] = "hadoop-data2"
      v.vmx["ethernet1.pcislotnumber"] = "36"
    end
    # copy private key so hosts can ssh using key authentication (the script below sets permissions to 600)
    data2.vm.provision :file do |file|
      file.source      = PRIVATE_KEY_SOURCE
      file.destination = PRIVATE_KEY_DESTINATION
    end
  end

end
