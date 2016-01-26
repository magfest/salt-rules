lsyncd:
  pkg.installed: []

replication-group:
  user.present:
    - name: replication
    - groups:
      - root

/home/replication/.ssh:
  file.directory:
    - mode: 700

/home/replication/.ssh/id_rsa:
  file.managed:
    - source: salt://containers/keys/replication
    - require:
      - file: /home/replication/.ssh
    - mode: 600
    - owner: replication
    - group: replication
