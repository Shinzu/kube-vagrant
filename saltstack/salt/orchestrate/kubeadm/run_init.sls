run_init:
  salt.state:
    - tgt: master
    - sls: kubeadm.kubeadm_init
