# kube-vagrant

With this repo you can setup a Kubernetes Cluster (commissioned with kubeadm) via vagrant.

##Prerequisites

vagrant installed (>= v2.2.0) , a version < 2.2.0 needs some adjustments in Vagrantfile or env.yaml

libvirt and qemu (on ubuntu/debian `apt-get install qemu libvirt-bin`)

you also need to install 2 vagrant plugins:

* [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)
* [vagrant-mutate](https://github.com/sciurus/vagrant-mutate)

this can be done simply via `vagrant plugin install <plugin name>` but there are some dependencies that you need to install first:

* vagrant-libvirt: `apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev`
* vagrant-mutate : `apt-get install qemu-utils libvirt-dev ruby-dev`

after that you are ready to beginn:

1. download source box bento/ubuntu-18.04: `vagrant box add bento/ubuntu-18.04`, choose here the virtualbox version
2. mutate the virtualbox box: `vagrant mutate bento/ubuntu-18.04 libvirt`
3. `vagrant up`

after the provisioning and kubeadm commissioning is done, you get a message howto adjust your kubectl config

now you are ready to play with the cluster, first you need to install an cni, you can use the flannel manifest from this repo or explore other like [cilium](https://cilium.io/) or [calico](https://www.projectcalico.org/)
