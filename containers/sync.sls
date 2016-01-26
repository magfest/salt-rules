lsyncd:
  pkg.installed: []

/home/replication/.ssh:
  file.directory:
    - mode: 700

/home/replication/.ssh/id_rsa:
  file.managed:
    - source: salt://containers/keys/replication
    - require:
      - file: /home/replication/.ssh
    - mode: 600
