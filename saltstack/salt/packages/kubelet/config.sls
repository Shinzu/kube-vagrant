/etc/systemd/system/kubelet.service.d:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - require:
      - pkg: kubelet

/etc/systemd/system/kubelet.service.d/10-kubeadm.conf:
  file.managed:
    - source: salt://{{ slspath }}/files/10-kubeadm.conf
    - mode: 644
    - template: jinja
    - require:
      - pkg: kubelet

reload_systemctl:
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    - require:
      - pkg: kubelet

restart_kubelet:
  module.run:
    - name: service.restart
    - m_name: kubelet
    - onchanges:
      - module: reload_systemctl
    - require:
      - pkg: kubelet

disable_swap:
  cmd.run:
    - name: 'swapoff -a && sudo sed -i "/ swap / s/^\(.*\)$/#\1/g" /etc/fstab && touch /etc/swap_disabled'
    - onlyif:
      - 'test ! -f /etc/swap_disabled'

mount_bpf:
  mount.mounted:
    - name: /sys/fs/bpf
    - device: bpffs
    - fstype: bpf
