include:
  - repositories.repo-kubernetes
{% if grains["nodename"] == "master" %}
  - packages.kubeadm.config
{% endif %}

kubeadm:
  pkg.installed:
    - version: {{ pillar['kubernetes_package_version'] }}
    - hold: True
    - update_holds: True
    - require:
      - sls: repositories.repo-kubernetes
