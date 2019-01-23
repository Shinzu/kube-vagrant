kubeadm_init:
  cmd.script:
    - source: salt://{{ slspath }}/files/kubeadm.sh
    - args: 'init'
