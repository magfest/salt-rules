lsyncd:
  pkg.installed: []

/root/.ssh/id_rsa:
  file.managed:
    - source: salt://containers/keys/replication
