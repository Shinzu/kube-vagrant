#! /usr/bin/env bash

OPERATION=${1:-}
KUBEADM_COMMAND=${2:-}

case $OPERATION in
  init)
    KUBEADM_COMMAND="sudo kubeadm init --config /etc/kubernetes/kubeadm.yaml"

    $KUBEADM_COMMAND > /root/kubeadm.log
    KUBEADM_JOIN=$(grep "kubeadm join" /root/kubeadm.log | sed -e 's/^[[:space:]]*//')
    salt-call event.send kubeadm/init join_command="$KUBEADM_JOIN"
    ;;
  join)
    KUBEADM_COMMAND=$KUBEADM_COMMAND

    $KUBEADM_COMMAND > /root/kubeadm.log
    ;;
esac
