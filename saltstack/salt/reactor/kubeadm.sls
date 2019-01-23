run_join:
  runner.state.orchestrate:
    - args:
      - mods: orchestrate.kubeadm.run_join
      - pillar:
          join_command: {{ data['data']['join_command'] }}
