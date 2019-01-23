include:
  - repositories.repo-docker

docker-ce:
  pkg.installed:
    - version: {{ pillar['docker_package_version'] }}
    - hold: True
    - update_holds: True
    - require:
      - sls: repositories.repo-docker
