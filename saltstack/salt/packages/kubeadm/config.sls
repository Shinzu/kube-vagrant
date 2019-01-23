/data:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - require:
      - pkg: kubeadm

/etc/kubernetes:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - require:
      - pkg: kubeadm

/etc/kubernetes/kubeadm.yaml:
  file.managed:
    - source: salt://{{ slspath }}/files/kubeadm.yaml
    - mode: 644
    - template: jinja
    - require:
      - pkg: kubeadm
