include:
  - repositories.repo-kubernetes
  - packages.kubelet.config

kubelet:
  pkg.installed:
    - version: {{ pillar['kubernetes_package_version'] }}
    - hold: True
    - update_holds: True
    - require:
      - sls: repositories.repo-kubernetes
