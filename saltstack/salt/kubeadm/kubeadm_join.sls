kubeadm_join:
  cmd.script:
    - source: salt://{{ slspath }}/files/kubeadm.sh
    - args: 'join "{{ pillar['join_command'] }}"'
