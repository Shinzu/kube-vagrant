run_join:
  salt.state:
    - tgt: 'worker*'
    - sls:
      - kubeadm.kubeadm_join
    - pillar:
        join_command: {{ pillar['join_command'] }}
