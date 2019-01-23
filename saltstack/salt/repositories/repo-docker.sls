include:
  - packages.apt-transport-https

pkgrepo_docker:
  pkgrepo:
    - managed
    - name: deb https://download.docker.com/linux/{{ grains['os']|lower }} {{ grains['oscodename'] }} stable
    - humanname: docker
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/{{ grains['os']|lower }}/gpg
    - clean_file: True
    - require:
      - pkg: apt-transport-https
