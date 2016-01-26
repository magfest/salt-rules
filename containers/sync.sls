lsyncd:
  pkg.installed: []

/root/.ssh:
  file.directory:
    - mode: 700

/root/.ssh/id_rsa:
  file.managed:
    - source: salt://containers/keys/root
    - require:
      - file: /root/.ssh
    - mode: 600
    - owner: root
    - group: root

/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://containers/keys/root.pub
    - require:
      - file: /root/.ssh
    - mode: 600
    - owner: root
    - group: root
