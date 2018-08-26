# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  ##
  ##  openldap_server
  ##
  # The "openldap_server" string is the name of the box.
  config.vm.define "ldap-server" do |server|
    server.vm.box = "kaorimatz/ubuntu-16.04-amd64"

    server.vm.hostname = "ldap.example.com"

    server.vm.network "private_network", ip: "192.168.33.253"

    server.vm.provider "virtualbox" do |vb|
      vb.linked_clone = true
      vb.memory = "1024"
    end
  
    server.vm.provision "shell", path: "provision.sh"
  end
  
  
  ##
  ## openldap-client - linux 7 boxes
  ##
  config.vm.define "openldap-client" do |client|
      client.vm.box = "kaorimatz/ubuntu-16.04-amd64"
      client.vm.hostname = "openldap-client.local"
      client.vm.network "private_network", ip: "192.168.33.241"
      client.vm.provider "virtualbox" do |vb|
        #vb.gui = true
        vb.memory = "1024"
        vb.cpus = 1
        #vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        #vb.name = "openldap-client"
      end
  end	  
end
