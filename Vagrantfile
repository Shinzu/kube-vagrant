# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
require 'yaml'

env = YAML.load_file('env.yml')

VAGRANT_BOX = env['vagrant_box'] or "generic/ubuntu1604"
MASTER_NODES = env['master_nodes'].to_i or 1
MASTER_NAME = env['master_node_name'] or 'master'
WORKER_NODES = env['worker_nodes'].to_i or 1
WORKER_NODE_NAME = env['worker_node_name'] or 'worker'
SUBNET = env['subnet'] or '10.0.2'
SALT_VERSION = env['salt_version'] or '2018.3'

Vagrant.configure("2") do |config|
  config.vm.provider 'libvirt'

  config.vm.box = VAGRANT_BOX

  config.vm.provider 'libvirt' do |lv|
    lv.management_network_mode = 'nat'
  end

  config.vm.define "master", primary: true do |master|
    master.vm.hostname = MASTER_NAME
    master.vm.network :private_network, :ip => "#{SUBNET}.50", :gateway => "#{SUBNET}.1", :dns_servers => "#{SUBNET}.1"
    master.vm.provider :libvirt do |domain|
      domain.memory = 2048
      domain.cpus = 2
    end
    master.vm.provision "shell", inline: "sudo echo '10.0.2.50 salt-master' >> /etc/hosts"
    master.vm.provision :salt do |salt|
      salt.install_master = true
      salt.master_config = "saltstack/etc/master"
      salt.minion_config = "saltstack/etc/minion"
      salt.install_type = "git"
      salt.version = SALT_VERSION
    end
  end

  (1..WORKER_NODES.to_i).each do |i|
    config.vm.define "worker0#{i}" do |worker|
      worker.vm.hostname = "#{WORKER_NODE_NAME}0#{i}"
      worker.vm.network :private_network, :ip => "#{SUBNET}.#{50+i}", :gateway => "#{SUBNET}.1", :dns_servers => "#{SUBNET}.1"
      worker.vm.provider :libvirt do |domain|
        domain.memory = 2048
        domain.cpus = 2
      end
      worker.vm.provision "shell", inline: "sudo echo '10.0.2.50 salt-master' >> /etc/hosts"
      worker.vm.provision :salt do |salt|
        salt.minion_config = "saltstack/etc/minion"
        salt.install_type = "git"
        salt.version = SALT_VERSION
      end
    end
  end

  config.trigger.after :up do |trigger|
    trigger.warn = "Running highstate"
    trigger.only_on = "master"
    trigger.run_remote = {inline: "while true ; do salt '*' test.ping ; if [ $? -eq 0 ] ; then salt '*' state.apply ; break ; fi ; sleep 10 ; done"}
  end

  config.trigger.after :up do |trigger|
    trigger.warn = "Running kubeadm to commission the cluster"
    trigger.only_on = "master"
    trigger.run_remote = {inline: "salt-run state.orch orchestrate.kubeadm.run_init"}
  end

  config.trigger.after :up do |trigger|
    trigger.warn = "Sync kubeconfig to local dir"
    trigger.only_on = "master"
    trigger.run = {path: "get_kubeconfig.sh"}
  end

  config.trigger.after :up do |trigger|
    trigger.warn = "Now you can set the env KUBECONFIG and switch to the cluster: export KUBECONFIG=$HOME/.kube/config:$(pwd)/admin.conf ; kubectl config use-context kubernetes-admin@kubernetes"
    trigger.only_on = "master"
  end

end
