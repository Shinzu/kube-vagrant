
include:
  - packages.apt-transport-https

pkgrepo_kubernetes:
  pkgrepo:
    - managed
    - name: deb https://apt.kubernetes.io/ kubernetes-xenial main
    - humanname: kubernetes
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - clean_file: True
    - require:
      - pkg: apt-transport-https
