#!/usr/bin/env bash

vagrant ssh-config > $(pwd)/ssh-config
rsync -e 'ssh -F ./ssh-config' --rsync-path 'sudo rsync' master:/etc/kubernetes/admin.conf $(pwd)/
